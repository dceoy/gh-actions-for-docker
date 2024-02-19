#!/usr/bin/env python

import argparse
import logging
import tomllib
from pathlib import Path

import yaml
from jinja2 import Environment, FileSystemLoader


def main():
    args = _parse_options()
    _set_log_config(args=args)
    logger = logging.getLogger(__name__)
    logger.debug("args:\t{}".format(vars(args)))
    root_dir = Path.cwd()
    readme_md = root_dir / "README.md"
    readme_md_j2 = root_dir / "templates" / f"{readme_md.name}.j2"
    workflow_dir = root_dir / ".github" / "workflows"
    _render_md(
        workflows=list(_detect_reusable_workflow(workflow_dir=workflow_dir)),
        template_md=readme_md_j2,
        output_md=readme_md,
    )


def _detect_reusable_workflow(workflow_dir):
    logger = logging.getLogger(__name__)
    _print_log(f"Detect reusable workflows: {workflow_dir}")
    for f in sorted(workflow_dir.iterdir(), key=lambda f: f.name):
        if f.is_file() and f.suffix == ".yml":
            logger.debug(f"Read YAML: {f}")
            with open(f, "r") as y:
                d = yaml.safe_load(y)
            logger.debug(f"YAML: {d}")
            if "name" in d and "workflow_call" in d[True]:
                logger.info(f"Found a reusable workflow: {f}")
                yield {"name": d["name"], "file": f.name}


def _render_md(workflows, template_md, output_md):
    _print_log(f"Render a Markdown file: {output_md}")
    new_text = (
        Environment(
            loader=FileSystemLoader(template_md.parent, encoding="utf8"),
            autoescape=True,
        )
        .get_template(template_md.name)
        .render(workflows=workflows)
    )
    with open(output_md, "w") as f:
        f.write(new_text)


def _print_log(message):
    logger = logging.getLogger(__name__)
    logger.info(message)
    print(">>\t{}".format(message), flush=True)


def _set_log_config(args):
    if args.debug:
        lv = logging.DEBUG
    elif args.info:
        lv = logging.INFO
    else:
        lv = logging.WARNING
    logging.basicConfig(
        format="%(asctime)s %(levelname)-8s %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
        level=lv,
    )


def _parse_options():
    parser = argparse.ArgumentParser(
        prog=Path(__file__).name, description="Markdown build script"
    )
    parser.add_argument(
        "--version", action="version", version="%(prog)s {}".format(_extract_version())
    )
    parser.add_argument(
        "--debug", dest="debug", action="store_true", help="log with DEBUG level"
    )
    parser.add_argument(
        "--info", dest="info", action="store_true", help="log with INFO level"
    )
    return parser.parse_args()


def _extract_version():
    pyproject_toml = Path(__file__).parent / "pyproject.toml"
    if pyproject_toml.is_file():
        with open(pyproject_toml, "rb") as f:
            data = tomllib.load(f)
        return data["tool"]["poetry"]["version"]
    else:
        return "v0.0.0"


if __name__ == "__main__":
    main()

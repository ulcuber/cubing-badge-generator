#!/usr/bin/env python3

import csv
import json
from math import floor
import subprocess
from os.path import realpath, dirname
from optparse import OptionParser


def get_options():
    parser = OptionParser()

    parser.add_option("-s", "--source", dest="json",
                      default=realpath("./json/results.json"), help="source JSON file")

    parser.add_option("-m", "--map", dest="csv",
                      default=realpath("./csv/fun-cubing-map.csv"), help="Disciplines CSV map")

    parser.add_option("-t", "--template", dest="template", default=realpath(
        "./templates/cubingrf_certificate_ul.xcf"), help="xcf (GIMP) template to use")

    parser.add_option("-g", "--scheme", dest="scheme",
                      default="cubingrf-certificate",
                      help="scm (GIMP script) scheme to use (name without extension)")

    return parser.parse_args()


def parse_time(num):
    if num == -1:
        return None

    ms = num % 100
    total_seconds = floor((num-ms) / 100)
    minutes = floor(total_seconds / 60)
    seconds = total_seconds % 60

    time = f"{seconds:02}.{ms}"
    if minutes:
        time = f"{minutes}:{time}"

    return time


def main():
    (options, args) = get_options()
    scheme = options.scheme
    source_filename = options.json
    template = options.template
    map_filename = options.csv

    shell_args = [
        "gimp",
        "-i",
    ]

    disciplines = dict()
    with open(map_filename, newline='') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)
        for row in reader:
            disciplines[row[0]] = row[1]

    with open(source_filename, newline='') as json_file:
        results = json.load(json_file)
        for result in results:
            name = result["name"]
            place = result["pos"]
            discipline = disciplines[result["event_id"]]

            time = parse_time(result["average"])
            if time:
                time = f"Ao5: {time}"
            else:
                time = parse_time(result["best"])
                time = f"Bo5: {time}"

            command = f'({scheme} "{template}" "{name}" "{place}" "{discipline}" "{time}")'
            shell_args.append("-b")
            shell_args.append(command)

    shell_args.append("-b")
    shell_args.append("(gimp-quit 0)")

    cwd = dirname(realpath(__file__))
    subprocess.call(shell_args, cwd=cwd)


if __name__ == "__main__":
    main()

# Vitamin D Shiny App

Simple R Shiny app that visualizes Vitamin D (25-Hydroxy) lab value trajectories.

The app can:

- plot all patient trajectories together, or
- plot an individual patient selected by MRN.

This repository contains a small demo app with generated sample data.

## Requirements

- R
- Packages: `shiny`, `ggplot2`

The app installs missing packages at startup from within `server.r`.

## Run locally

From the project root:

```r
shiny::runApp()
```

Or from a shell:

```bash
R -e "shiny::runApp('/workspace')"
```

Then open the local URL shown in the console.

## Project files

- `ui.r` - user interface (MRN selector, "Plot everyone" option, and plot panel)
- `server.r` - plotting logic and fake data generation
- `fakeData.RData` - sample data file included in repo

## Notes

- This app currently uses generated fake data in `server.r`.
- It was originally created for URAP Vitamin D patient data visualization.

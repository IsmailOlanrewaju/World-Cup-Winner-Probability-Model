# Data Description

This folder contains the dataset used as input for the World Cup Monte Carlo simulation model.

The dataset contains calculated team strength ratings derived from tournament performance metrics.

Each row represents one national team participating in the knockout stage.

---

# Dataset

## team_strength.csv

This file contains the adjusted attacking and defensive strength ratings used in the match simulation model.

The dataset includes the following variables:

| Variable | Description |
|----------|-------------|
| team | Country name used as the identifier in the simulation |
| adj_attack_strength | Adjusted attacking strength rating |
| adj_defence_strength | Adjusted defensive strength rating |

---

# Variable Explanation

## team

The national team name used in the knockout simulation.

Examples:

- spain
- france
- argentina
- england

Country names must match the team names provided in the tournament fixtures.

---

## adj_attack_strength

Represents the team's attacking ability relative to the tournament average.

Higher values indicate stronger attacking performance.

The rating was developed using attacking performance indicators such as:

- Goals scored
- Expected goals (xG)
- Shots
- Shots on target
- Passes into the final third

The value was adjusted using shrinkage to reduce the impact of limited tournament observations.

---

## adj_defence_strength

Represents the team's defensive ability relative to the tournament average.

Higher values indicate stronger defensive performance.

The rating incorporates defensive indicators such as:

- Goals conceded
- Expected goals against (xGA)
- Opponent shots on target
- Defensive actions

Higher defensive strength reduces opponent expected goals in the simulation model.

---

# Example Dataset Structure

| team | adj_attack_strength | adj_defence_strength |
|------|--------------------|---------------------|
| spain | 1.396590 | 1.900000 |
| belgium | 1.482586 | 1.103288 |
| france | ... | ... |
| argentina | ... | ... |

---

# Usage in Model

The dataset is loaded into R using:

```r
teams <- read.csv("team_strength.csv")

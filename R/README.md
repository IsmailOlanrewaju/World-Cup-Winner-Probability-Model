# R Script

This folder contains the R script used to run the complete **World Cup Monte Carlo Simulation Model**.

The script performs the full modelling workflow, including:

- Loading team strength data
- Simulating individual matches
- Simulating the knockout tournament
- Running Monte Carlo simulations
- Estimating championship probabilities
- Visualising final predictions

---

# Script

## `worldcup_monte_carlo_simulation.R`

This script contains the complete simulation framework.

The analysis follows the workflow:

```
Team Strength Data
        ↓
Expected Goals Calculation
        ↓
Match Simulation
        ↓
Knockout Tournament Simulation
        ↓
10,000 Monte Carlo Simulations
        ↓
Championship Probability Estimates
        ↓
Visualisation
```

---

# 1. Loading Team Strength Data

The script begins by loading the adjusted team strength dataset:

```r
teams <- read.csv("team_strength.csv")
```

The dataset contains the strength ratings used in the simulation model.

Variables:

| Variable | Description |
|---|---|
| `team` | Country name used in the simulation |
| `adj_attack_strength` | Adjusted attacking strength rating |
| `adj_defence_strength` | Adjusted defensive strength rating |

These values represent each country's attacking and defensive ability relative to the tournament average.

---

# 2. Tournament Fixture Setup

The remaining knockout-stage fixtures are defined manually:

```r
quarter_finals <- list(
  c("spain", "belgium"),
  c("argentina", "switzerland"),
  c("england", "norway"),
  c("morocco", "france")
)
```

Each pair represents one quarter-final match.

---

# 3. Match Simulation

The function:

```r
simulate_match()
```

is used to simulate individual football matches.

The function requires:

- Team 1
- Team 2
- Team strength dataset
- Tournament average goals

Example:

```r
simulate_match(
  "spain",
  "belgium",
  teams,
  baseline_goals
)
```

---

## Expected Goals Calculation

The expected goals for each team are calculated using:

\[
\lambda_i =
Baseline\ Goals
\times
\frac{Attack_i}{Opponent\ Defence}
\]

Where:

- \( \lambda_i \) = expected goals for team i
- Attack = adjusted attacking strength
- Defence = adjusted defensive strength

A stronger defence reduces the opponent's expected goals.

---

## Goal Simulation

Goals are generated using a Poisson distribution:

\[
Goals_i \sim Poisson(\lambda_i)
\]

The simulated scores determine the match winner.

Rules:

- Higher goals → winner
- Equal goals → penalty shootout assumption

For simulated draws, the winner is selected randomly:

```r
sample(c(team1, team2), 1)
```

This represents knockout football uncertainty.

---

# 4. Match-Level Validation

The script tests the match simulation by repeatedly simulating the same fixture:

```r
replicate(
10000,
simulate_match(
"spain",
"belgium",
teams,
baseline_goals
))
```

This estimates the probability of each team winning a single match.

---

# 5. Tournament Simulation

The function:

```r
simulate_tournament()
```

simulates the complete knockout tournament.

The tournament structure:

```
Quarter-finals
       ↓
Semi-finals
       ↓
Final
       ↓
Champion
```

Each tournament simulation returns one champion.

Example:

```r
simulate_tournament(
teams,
quarter_finals,
baseline_goals
)
```

Possible output:

```
"france"
```

---

# 6. Monte Carlo Simulation

The complete tournament is simulated 10,000 times.

Code:

```r
set.seed(123)

tournament_results <- replicate(
10000,
simulate_tournament(
teams,
quarter_finals,
baseline_goals
)
)
```

Each simulation represents one possible tournament outcome.

Because match outcomes contain randomness, different simulations can produce different champions.

---

# 7. Championship Probability Calculation

The number of championships won by each country is counted:

```r
winner_count <- table(tournament_results)
```

The championship probability is calculated as:

\[
Winning\ Probability =
\frac{Number\ of\ Championships}
{Total\ Simulations}
\times100
\]

Code:

```r
winner_probability <- winner_count / 10000

winner_probability * 100
```

---

# 8. Final Prediction Table

The simulation results are converted into a ranked table:

```r
final_prediction <- data.frame(
Team = names(winner_probability),
Win_Probability = as.numeric(winner_probability) * 100
)
```

The teams are sorted from highest to lowest championship probability.

Example:

| Team | Winning Probability (%) |
|---|---:|
| France | 24.75 |
| Spain | 21.23 |
| Argentina | 16.36 |
| England | 11.90 |

---

# 9. Visualisation

The model uses `ggplot2` to create a championship probability chart.

```r
library(ggplot2)

ggplot(final_prediction,
aes(
x=reorder(Team, Win_Probability),
y=Win_Probability
)) +
geom_col() +
coord_flip() +
labs(
title="Predicted World Cup Winning Probability",
x="Team",
y="Probability (%)"
) +
theme_minimal()
```

The chart displays the estimated probability of each country winning the tournament.

---

# Required Packages

The script requires:

```r
library(ggplot2)
```

Install if necessary:

```r
install.packages("ggplot2")
```

---

# How to Run the Script

Before running:

1. Ensure `team_strength.csv` is available.
2. Set the working directory to the project folder.
3. Run:

```r
source("worldcup_monte_carlo_simulation.R")
```

---

# Outputs Generated

The script produces:

- Single-match simulation results
- Tournament simulation outcomes
- Championship probability estimates
- Ranked prediction table
- Championship probability visualisation

The final outputs are stored in the `outputs/` folder.

---

# Methodological Note

This model does not attempt to predict football outcomes with certainty.

Instead, it estimates championship probabilities by simulating thousands of possible tournament scenarios under the assumption that:

- Current team strength reflects future performance
- Match goals follow a Poisson process
- Knockout matches contain inherent randomness

The results should therefore be interpreted as model-based probabilities rather than guaranteed outcomes.

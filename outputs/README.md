# Model Outputs

This folder contains the final results generated from the **World Cup Monte Carlo Simulation Model**.

The outputs are produced after running **10,000 simulated knockout tournaments** using team strength ratings, expected goals modelling, and Poisson-based match simulation.

---

# Output Files

## `Team Win_Probability.csv`

This file contains the estimated probability of each country winning the tournament.

The probabilities are calculated from the number of times each country becomes champion across all simulated tournaments.

The calculation is:

\[
Winning\ Probability =
\frac{Number\ of\ Tournament\ Wins}
{Total\ Number\ of\ Simulations}
\times100
\]

Example:

| Team | Winning Probability (%) |
|---|---:|
| France | 24.75 |
| Spain | 21.23 |
| Argentina | 16.36 |
| England | 11.90 |

Each row represents one country and its estimated chance of winning the tournament.

---

# `winner_probability_plot.png`

This visualisation displays the estimated championship probabilities from the Monte Carlo simulation.

The chart allows comparison of:

- Most likely tournament winners
- Relative differences between teams
- Overall competitiveness of the knockout stage

Higher bars indicate a greater estimated probability of winning the tournament.

---

# Simulation Summary

The results are generated from:

- 10,000 complete tournament simulations
- Knockout-stage match simulation
- Expected goals framework
- Poisson goal generation
- Random penalty shootout outcomes for simulated draws

Each simulation follows:

```
Quarter-finals
       ↓
Semi-finals
       ↓
Final
       ↓
Tournament Champion
```

---

# Interpretation

The outputs represent **estimated probabilities**, not guaranteed outcomes.

For example, if a country has a 25% championship probability, this means it won approximately 25% of simulated tournaments under the assumptions of the model.

The uncertainty reflects the unpredictable nature of knockout football, where a single match outcome can significantly influence the final result.

---

# Purpose

The output files provide a concise summary of the model predictions and allow the results of the Monte Carlo simulation to be analysed, visualised, and compared across teams.

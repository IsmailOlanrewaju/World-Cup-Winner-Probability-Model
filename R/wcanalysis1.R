teams <- read.csv("team_strength.csv")
quarter_finals <- list(
  c("spain", "belgium"),
  c("argentina", "switzerland"),
  c("england", "norway"),
  c("morocco", "france")
)
baseline_goals <- 1.46
simulate_match <- function(team1, team2, teams, baseline_goals){

  # Get team parameters
  attack1 <- teams$adj_attack_strength[teams$team == team1]
  defence1 <- teams$adj_defence_strength[teams$team == team1]

  attack2 <- teams$adj_attack_strength[teams$team == team2]
  defence2 <- teams$adj_defence_strength[teams$team == team2]


  # Calculate expected goals
  lambda1 <- baseline_goals * attack1 / defence2
lambda2 <- baseline_goals * attack2 / defence1

  # Simulate goals
  goals1 <- rpois(1, lambda1)
  goals2 <- rpois(1, lambda2)


  # Determine winner
  if(goals1 > goals2){

    winner <- team1

  } else if(goals2 > goals1){

    winner <- team2

  } else {

    # penalty shootout (50/50 assumption)
    winner <- sample(c(team1, team2), 1)

  }

  return(winner)

}
simulate_match(
  "spain",
  "belgium",
  teams,
  baseline_goals
)

replicate(20,simulate_match("spain","belgium",teams,baseline_goals))
spain <- teams[teams$team=="spain",]
belgium <- teams[teams$team=="belgium",]

table(replicate(10000,
simulate_match("spain","belgium",teams,baseline_goals)))

simulate_tournament <- function(teams, quarter_finals, baseline_goals){

  # Quarter-finals
  qf_winners <- c()

  for(match in quarter_finals){

    winner <- simulate_match(
      match[1],
      match[2],
      teams,
      baseline_goals
    )

    qf_winners <- c(qf_winners, winner)
  }


  # Semi-finals
  semi_finals <- list(
    c(qf_winners[1], qf_winners[2]),
    c(qf_winners[3], qf_winners[4])
  )


  sf_winners <- c()

  for(match in semi_finals){

    winner <- simulate_match(
      match[1],
      match[2],
      teams,
      baseline_goals
    )

    sf_winners <- c(sf_winners, winner)
  }


  # Final
  champion <- simulate_match(
    sf_winners[1],
    sf_winners[2],
    teams,
    baseline_goals
  )


  return(champion)

}
replicate(
  10,
  simulate_tournament(
    teams,
    quarter_finals,
    baseline_goals
  )
)

set.seed(123)

tournament_results <- replicate(
  10000,
  simulate_tournament(
    teams,
    quarter_finals,
    baseline_goals
  )
)
winner_count <- table(tournament_results)

winner_count
winner_probability <- winner_count / 10000

winner_probability
winner_probability * 100
sort(winner_probability * 100, decreasing = TRUE)


final_prediction <- data.frame(
  Team = names(winner_probability),
  Win_Probability = as.numeric(winner_probability) * 100
)

final_prediction <- final_prediction[
  order(-final_prediction$Win_Probability),
]

final_prediction
library(ggplot2)

ggplot(final_prediction,
       aes(x=reorder(Team, Win_Probability),
           y=Win_Probability)) +
  geom_col() +
  coord_flip() +
  labs(
    title="Predicted World Cup Winning Probability",
    x="Team",
    y="Probability (%)"
  ) +
  theme_minimal()
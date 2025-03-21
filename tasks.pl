:- consult('league_data.pl').


 %task 1

players_in_team(Team, Players) :-
    players_in_team_helper(Team, [], Players).


players_in_team_helper(Team, Acc, Players) :-
    player(Player, Team, _),
    \+ member(Player, Acc),
    players_in_team_helper(Team, [Player | Acc], Players).
players_in_team_helper(_, Players, Players).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %task 2


team_count_by_country(Country, Count) :-
    team_count_by_country_helper(Country, 0, [], Count).


team_count_by_country_helper(Country, Acc, TeamsChecked, Count) :-
    team(Team, Country, _),
    \+ member(Team, TeamsChecked),
    NewAcc is Acc + 1,
    team_count_by_country_helper(Country, NewAcc, [Team | TeamsChecked], Count).
team_count_by_country_helper(_, Count, _, Count).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   %task 3


most_successful_team(Team) :-
    team(FirstTeam, _, FirstTitles),
    most_successful_team_helper(FirstTeam, FirstTitles, Team).


most_successful_team_helper(CurrentTeam, CurrentTitles, MostSuccessfulTeam) :-
    team(NextTeam, _, NextTitles),
    NextTitles > CurrentTitles,
    most_successful_team_helper(NextTeam, NextTitles, MostSuccessfulTeam).
most_successful_team_helper(MostSuccessfulTeam, _, MostSuccessfulTeam).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 %task 5   still have problem

num_matches_of_team(Team, Count) :-
    num_matches_of_team_helper(Team, 0, Count).

% Helper predicate with accumulator
num_matches_of_team_helper(Team, Acc, Count) :-
    match(Team, _, _, _),          % Check if the team participated as Team1
    NewAcc is Acc + 1,             % Increment the count
    num_matches_of_team_helper(Team, NewAcc, Count). % Recursively count the remaining matches
num_matches_of_team_helper(Team, Acc, Count) :-
    match(_, Team, _, _),          % Check if the team participated as Team2
    NewAcc is Acc + 1,             % Increment the count
    num_matches_of_team_helper(Team, NewAcc, Count). % Recursively count the remaining matches
num_matches_of_team_helper(_, Count, Count). % Base case: return the accumulator


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 %task 6

% Main predicate to find the top goal scorer
top_scorer(Player) :-
    goals(FirstPlayer, FirstGoals), % Start with the first player
    top_scorer_helper(FirstPlayer, FirstGoals, Player).

% Helper predicate with accumulator
top_scorer_helper(CurrentPlayer, CurrentGoals, TopScorer) :-
    goals(NextPlayer, NextGoals),   % Find the next player
    NextGoals > CurrentGoals,       % Check if the next player has more goals
    top_scorer_helper(NextPlayer, NextGoals, TopScorer). % Update the accumulator
top_scorer_helper(TopScorer, _, TopScorer). % Base case: return the top scorer







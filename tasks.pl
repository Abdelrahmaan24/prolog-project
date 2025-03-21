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

num_matches_of_team_helper(Team, Acc, Count) :-
    match(Team, _, _, _),
    NewAcc is Acc + 1,
    num_matches_of_team_helper(Team, NewAcc, Count).
num_matches_of_team_helper(Team, Acc, Count) :-
    match(_, Team, _, _),
    NewAcc is Acc + 1,
    num_matches_of_team_helper(Team, NewAcc, Count).
num_matches_of_team_helper(_, Count, Count).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 %task 6

top_scorer(Player) :-
    goals(FirstPlayer, FirstGoals),
    top_scorer_helper(FirstPlayer, FirstGoals, Player).

top_scorer_helper(CurrentPlayer, CurrentGoals, TopScorer) :-
    goals(NextPlayer, NextGoals),
    NextGoals > CurrentGoals,
    top_scorer_helper(NextPlayer, NextGoals, TopScorer).
top_scorer_helper(TopScorer, _, TopScorer).

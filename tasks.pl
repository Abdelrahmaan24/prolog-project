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
%task 4
matches_of_team(Team, Matches) :-
    collect_matches(Team, [], Matches).

collect_matches(Team, Acc, Matches) :-
    match(Team, Opponent, Goals1, Goals2),  % Team is Team1
    \+ member((Team, Opponent, Goals1, Goals2), Acc),  % Avoid duplicates
    collect_matches(Team, [(Team, Opponent, Goals1, Goals2) | Acc], Matches).

collect_matches(Team, Acc, Matches) :-
    match(Opponent, Team, Goals1, Goals2),  % Team is Team2
    \+ member((Opponent, Team, Goals1, Goals2), Acc),  % Avoid duplicates
    collect_matches(Team, [(Opponent, Team, Goals1, Goals2) | Acc], Matches).

collect_matches(_, Matches, Matches).  % Base case: return collected list

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 %task 5   still have problem
num_matches_of_team(Team, Count) :-
    count_matches(Team, 0, Count, []).

count_matches(Team, Acc, Count, Seen) :-
    match(Team, Opponent, _, _),  % Team appears as Team1
    \+ member((Team, Opponent), Seen),  % Avoid duplicate counting
    NewAcc is Acc + 1,
    count_matches(Team, NewAcc, Count, [(Team, Opponent) | Seen]).

count_matches(Team, Acc, Count, Seen) :-
    match(Opponent, Team, _, _),  % Team appears as Team2
    \+ member((Opponent, Team), Seen),  % Avoid duplicate counting
    NewAcc is Acc + 1,
    count_matches(Team, NewAcc, Count, [(Opponent, Team) | Seen]).

count_matches(_, Count, Count, _).  % Base case: return final count

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

:- consult('league_data.pl').


    % task 1

players_in_team(Team, Players) :-
    players_in_team_helper(Team, [], Players).


players_in_team_helper(Team, Acc, Players) :-
    player(Player, Team, _),
    \+ member(Player, Acc),
    players_in_team_helper(Team, [Player | Acc], Players).
players_in_team_helper(_, Players, Players).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % task 2


team_count_by_country(Country, Count) :-
    team_count_by_country_helper(Country, 0, [], Count).


team_count_by_country_helper(Country, Acc, TeamsChecked, Count) :-
    team(Team, Country, _),
    \+ member(Team, TeamsChecked),
    NewAcc is Acc + 1,
    team_count_by_country_helper(Country, NewAcc, [Team | TeamsChecked], Count).
team_count_by_country_helper(_, Count, _, Count).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % task 3

most_successful_team(Team) :-
    team(FirstTeam, _, FirstTitles), 
    most_successful_team_helper(FirstTeam, FirstTitles, Team).

most_successful_team_helper(CurrentTeam, CurrentTitles, MostSuccessfulTeam) :-
    team(NextTeam, _, NextTitles),   
    NextTitles > CurrentTitles,      
    most_successful_team_helper(NextTeam, NextTitles, MostSuccessfulTeam). 
most_successful_team_helper(MostSuccessfulTeam, _, MostSuccessfulTeam). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % task 4

matches_of_team(Team, Matches) :-
    collect_matches(Team, [], Matches).

collect_matches(Team, Acc, Matches) :-
    match(Team, Opponent, Goals1, Goals2),  
    \+ member((Team, Opponent, Goals1, Goals2), Acc),  
    collect_matches(Team, [(Team, Opponent, Goals1, Goals2) | Acc], Matches).

collect_matches(Team, Acc, Matches) :-
    match(Opponent, Team, Goals1, Goals2),  
    \+ member((Opponent, Team, Goals1, Goals2), Acc),  
    collect_matches(Team, [(Opponent, Team, Goals1, Goals2) | Acc], Matches).

collect_matches(_, Matches, Matches).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % task 5  

num_matches_of_team(Team, Count) :-
    count_matches(Team, 0, Count, []).

count_matches(Team, Acc, Count, Seen) :-
    match(Team, Opponent, _, _),  
    \+ member((Team, Opponent), Seen),  
    NewAcc is Acc + 1,
    count_matches(Team, NewAcc, Count, [(Team, Opponent) | Seen]).

count_matches(Team, Acc, Count, Seen) :-
    match(Opponent, Team, _, _),  
    \+ member((Opponent, Team), Seen),  
    NewAcc is Acc + 1,
    count_matches(Team, NewAcc, Count, [(Opponent, Team) | Seen]).

count_matches(_, Count, Count, _). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % task 6

top_scorer(Player) :-
    goals(FirstPlayer, FirstGoals),
    top_scorer_helper(FirstPlayer, FirstGoals, Player).

top_scorer_helper(CurrentPlayer, CurrentGoals, TopScorer) :-
    goals(NextPlayer, NextGoals),
    NextGoals > CurrentGoals,
    top_scorer_helper(NextPlayer, NextGoals, TopScorer).
top_scorer_helper(TopScorer, _, TopScorer).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % task 7

not_seen_before(Player, CheckedPlayers) :-
    \+ member(Player, CheckedPlayers).



most_common_position_in_team(Team, Position) :-
    gather_positions(Team, [], [], Positions),
    myReverse(Positions, RevPositions),
    tally_positions(RevPositions, [], PositionCounts),
    find_highest_count(PositionCounts, Position).

gather_positions(Team, CheckedPlayers, TempPositions, Positions) :-
    player(PlayerName, Team, Position),
    not_seen_before(PlayerName, CheckedPlayers),
    gather_positions(Team, [PlayerName | CheckedPlayers], [Position | TempPositions], Positions).
gather_positions(_, _, Positions, Positions).

tally_positions([], Counts, Counts).
tally_positions([Position|Rest], Acc, Counts) :-
    update_tally(Position, Acc, UpdatedAcc),
    tally_positions(Rest, UpdatedAcc, Counts).

update_tally(Position, [], [(Position, 1)]).
update_tally(Position, [(Position, Count)|Rest], [(Position, NewCount)|Rest]) :-
    NewCount is Count + 1.
update_tally(Position, [Other|Rest], [Other|UpdatedRest]) :-
    update_tally(Position, Rest, UpdatedRest).

find_highest_count([(Position, _)], Position).
find_highest_count([(Position1, Count1), (Position2, Count2)|Rest], MaxPosition) :-
    (Count1 >= Count2 ->
        find_highest_count([(Position1, Count1)|Rest], MaxPosition);
        find_highest_count([(Position2, Count2)|Rest], MaxPosition)).

myReverse(List, Reversed) :-
    myReverseHelper(List, [], Reversed).

myReverseHelper([], Acc, Acc).
myReverseHelper([H|T], Acc, Reversed) :-
    myReverseHelper(T, [H|Acc], Reversed).

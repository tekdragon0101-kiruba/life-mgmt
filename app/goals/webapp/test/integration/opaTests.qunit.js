sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/goforward/goals/test/integration/FirstJourney',
		'com/goforward/goals/test/integration/pages/GoalsList',
		'com/goforward/goals/test/integration/pages/GoalsObjectPage'
    ],
    function(JourneyRunner, opaJourney, GoalsList, GoalsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/goforward/goals') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGoalsList: GoalsList,
					onTheGoalsObjectPage: GoalsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
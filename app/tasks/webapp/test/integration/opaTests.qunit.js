sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/goforward/tasks/test/integration/FirstJourney',
		'com/goforward/tasks/test/integration/pages/TasksList',
		'com/goforward/tasks/test/integration/pages/TasksObjectPage'
    ],
    function(JourneyRunner, opaJourney, TasksList, TasksObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/goforward/tasks') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTasksList: TasksList,
					onTheTasksObjectPage: TasksObjectPage
                }
            },
            opaJourney.run
        );
    }
);
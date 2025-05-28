sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/goforward/resources/test/integration/FirstJourney',
		'com/goforward/resources/test/integration/pages/LearningResourcesList',
		'com/goforward/resources/test/integration/pages/LearningResourcesObjectPage'
    ],
    function(JourneyRunner, opaJourney, LearningResourcesList, LearningResourcesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/goforward/resources') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheLearningResourcesList: LearningResourcesList,
					onTheLearningResourcesObjectPage: LearningResourcesObjectPage
                }
            },
            opaJourney.run
        );
    }
);
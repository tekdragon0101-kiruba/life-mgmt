sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/goforward/learningresources/test/integration/FirstJourney',
		'com/goforward/learningresources/test/integration/pages/LearningResourcesList',
		'com/goforward/learningresources/test/integration/pages/LearningResourcesObjectPage'
    ],
    function(JourneyRunner, opaJourney, LearningResourcesList, LearningResourcesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/goforward/learningresources') + '/index.html'
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
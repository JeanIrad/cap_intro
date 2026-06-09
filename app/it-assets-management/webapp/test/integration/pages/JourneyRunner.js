sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"it/assets/management/itassetsmanagement/test/integration/pages/AssetsList",
	"it/assets/management/itassetsmanagement/test/integration/pages/AssetsObjectPage"
], function (JourneyRunner, AssetsList, AssetsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('it/assets/management/itassetsmanagement') + '/test/flp.html#app-preview',
        pages: {
			onTheAssetsList: AssetsList,
			onTheAssetsObjectPage: AssetsObjectPage
        },
        async: true
    });

    return runner;
});


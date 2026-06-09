sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"it/assets/management/alp/test/integration/pages/AssetStockList",
	"it/assets/management/alp/test/integration/pages/AssetStockObjectPage"
], function (JourneyRunner, AssetStockList, AssetStockObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('it/assets/management/alp') + '/test/flp.html#app-preview',
        pages: {
			onTheAssetStockList: AssetStockList,
			onTheAssetStockObjectPage: AssetStockObjectPage
        },
        async: true
    });

    return runner;
});


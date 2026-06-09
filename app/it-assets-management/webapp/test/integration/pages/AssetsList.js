sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'it.assets.management.itassetsmanagement',
            componentId: 'AssetsList',
            contextPath: '/Assets'
        },
        CustomPageDefinitions
    );
});
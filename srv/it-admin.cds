using {it.assets.management as mo} from '../db/schema';

@requires: 'IT_Admin'
service Admin @(path: '/admin')  {

entity Assets as projection on mo.Assets;

@odata.draft.enabled
entity Requests as projection on mo.Requests actions{

action approveRequest(allocatedAssetId: Assets:ID);
}

// @odata.draft.enabled
entity HardwareTypes as projection on mo.HardwareTypes{
    key code,
    name,
    descr,
    parent
};

entity Employees as projection on mo.Employees{
    key ID,
    name,
    email,
    department
};

}
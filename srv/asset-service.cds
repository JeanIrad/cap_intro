using {it.assets.management as db} from '../db/schema';


@cds.query.limit: {limit: 20, max: 100}
service AssetManagementService @(path: '/asset-management') {

    // @restrict: [
    //     {grant: '*', to :'IT_Admin'},
    //     {grant: 'READ', to :'Employee'},
    //     {grant: 'READ', to :'IT_Viewer'},
    // ]
    @cds.redirection.target
    entity Assets as projection on db.Assets;

    //   @restrict: [
    //     { grant: '*',                        to: 'IT_Admin'  },
    //     { grant: [ 'READ', 'CREATE' ],       to: 'Employee' , where: 'createdBy = $user' },
    //     { grant: 'READ',                     to: 'IT_Viewer' }
    // ]
    entity Requests   as projection on db.Requests;

    @readonly
    entity HardwareTypes as projection on db.HardwareTypes;

    @readonly
    entity Employees     as projection on db.Employees;

    //  @readonly
    entity AssetStock as select from db.Assets {
       key hardwareType.code as typeCode   : String,
        hardwareType.name as typeName   : String,
        count(*)                        as total     : Integer,
        count(case when status = 'Available' then 1 end) as available : Integer
    } group by hardwareType.code, hardwareType.name;


}



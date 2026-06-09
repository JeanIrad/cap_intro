using {managed, cuid, sap} from '@sap/cds/common';

namespace it.assets.management;

entity HardwareTypes: sap.common.CodeList {
    key code: String(50);
    parent: Association to HardwareTypes {code};

}

@assert.unique: {
    serialNumber: [serialNumber]
}


@odata.etag: modifiedAt
entity Assets: managed, cuid{
    serialNumber: String not null;
    model: String not null;
    status: AssetStatus default 'Available';
    price: Decimal(9, 2);
    hardwareType: Association to HardwareTypes;
    purchaseDate    : Date;
    vendor          : String;
    currentEmployee: Association to Employees;
}


    @odata.etag: modifiedAt
entity Requests: managed, cuid{
    justification: String;
    approvalStatus: ApprovalStatus default 'Pending';
    requestedType: Association to HardwareTypes;
    allocatedAsset: Association to Assets;
    requestedBy: Association to Employees not null;
    approvedBy: Association to Employees;
    assignDate: Date;

}

@assert.unique: {email: [email]}
entity Employees: managed, cuid{
   name: String not null;
    email: String not null;
    department: String; 
}
type AssetStatus    : String enum { Available; Assigned; In_Repair; Scrapped };
type ApprovalStatus : String enum { Pending; Approved; Rejected };
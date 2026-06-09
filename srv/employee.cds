using {it.assets.management as mo } from '../db/schema';

service Employee  @(path: '/employees'){


@odata.draft.enabled
entity Requests as projection on mo.Requests actions{
    
action cancelRequest ()
};

@readonly
entity HardwareTypes as projection on mo.HardwareTypes{
    key code,
    name,
    descr,
    parent
};


}


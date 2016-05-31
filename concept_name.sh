select c.concept_id, 
case when (c.uuid is not null) then 
	(
	select cn.name 
    from concept_name cn 
    where cn.concept_id =c.concept_id 
    and cn.voided=0 
	and cn.locale='en' and cn.concept_name_type = 'FULLY_SPECIFIED') 
    else ifnull(c.uuid, '') 
    end as 'FullySpecified',
case when (c.uuid is not null) then 
        (
        select cn.name 
        from concept_name cn
        where cn.concept_id =c.concept_id
            and cn.voided=0                       
            and cn.concept_name_type = 'SHORT' and cn.locale='en' limit 0,1
        ) 
     else ifnull(c.uuid, '') 
	 end as 'ShortName',
     case when (c.uuid is not null) then 
        (
        select cn.name 
        from concept_name cn
        where cn.concept_id =c.concept_id
            and cn.voided=0                       
            and cn.concept_name_type = 'SHORT' and cn.locale='es' limit 0,1
        )
        end as 'ShortName'
from concept c;

insert into [CustMaster].[Facilities]
(
	  [FacilityUCM]
      ,[IsNotInUCM]
      ,[BusType]
      ,[AddressType]
      ,[Name1]
      ,[City]
      ,[StateCode]
      ,[ZipCode]
      ,[CountryCode]
      ,[StartDate]
      ,[StopDate]
      ,[ParentUCM]
      ,[Notes]
      ,[IsMobile]
      ,[GPOId]
      ,[BEOAcctId]
      ,[SubParentId]
      ,[GEParentUCM]
      ,[ClassificationId]
)

Select  xrs.FacilityUCM
		,1 as IsNotInUCM
		,'GE!' as BusType
		,'M' as AddressType
		,xr.Name1
		,xr.City
		,xr.StateCode
		,xr.ZipCode
		,xr.CountryCode
		,'01-01-2000' as StartDate
		,'12-31-2099' as StopDate
		,xrs.FacilityUCM as ParentUCM
		,'Manual Inserts for Invalids - Wen' as notes
		,0 as ISMobile
		,0 as GPOId
		,0 as BEOAcctId
		,0 as SubParentId
		,xrs.FacilityUCM as GEParentUCM
		,0 as ClassificationId
  from CustMaster.XRefs xr inner join UniverseSrc.UCMToXRefs xrs
	on xr.DataSrcId = xrs.DataSrcId 
	and xr.GEAddressTypeId = xrs.GEAddressTypeId
	and xr.CustomerNbr = xrs.CustomerNbr 
	and xr.LocationNbr = xrs.LocationNbr
	left join CustMaster.Facilities cf
	on xrs.FacilityUCM = cf.FacilityUCM
	Where xr.FacilityUCM <> xrs.FacilityUCM
	and cf.FacilityUCM is null
	and xrs.FacilityUCM <> 'NA'
group by 
		xrs.FacilityUCM

		,xr.Name1
		,xr.City
		,xr.StateCode
		,xr.ZipCode
		,xr.CountryCode

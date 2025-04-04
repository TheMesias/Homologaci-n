-- SUMMARY
SELECT 
	COUNT(DISTINCT (A.atmkey)) AS totatm,
	'' AS location,
	'' operationalhours,
    CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(InServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Service %',
   	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OutofServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Out of Service %',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 100.00 ELSE SUM(cast(inactivesecs AS BIGINT)) * 100.00 / (SUM(cast(TotalTimeofopsecs AS BIGINT)) + SUM(cast(inactivesecs AS BIGINT))) END AS 'Inactive Service %',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCashOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Cash Out',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToMaintenanceSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Maintenance',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Hard Faults',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'SW Faults',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSupplyOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Supply Out',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCommDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Communication Lost',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHostDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Host Down',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToVandalismSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Vandalism' 
FROM 
	sstob..AVL_TERMINAL_SUMMARY_NO_ATM_BLACKLIST  (nolock) a inner join
	sstob..CUSTOMATMDATA (nolock) cd on a.atmkey = cd.atmkey
WHERE 
	a.summaryday >= dbo.FN_GetUTCFromUserInputTime([(FROM DATE)], [(TIME ZONE)]) 
	AND a.summaryday <= dbo.FN_GetUTCFromUserInputTime([(TO DATE)], [(TIME ZONE)]) 
	AND cd.TermId IN ([(TERMINAL BP)])

-- SUMMARY
SELECT 
	COUNT(DISTINCT (A.atmkey)) AS totatm,
	'' AS location,
	'' operationalhours,
    CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(InServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Service %',
   	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OutofServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Out of Service %',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 100.00 ELSE SUM(cast(inactivesecs AS BIGINT)) * 100.00 / (SUM(cast(TotalTimeofopsecs AS BIGINT)) + SUM(cast(inactivesecs AS BIGINT))) END AS 'Inactive Service %',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCashOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Cash Out',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToMaintenanceSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Maintenance',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Hard Faults',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'SW Faults',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSupplyOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Supply Out',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCommDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Communication Lost',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHostDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Host Down',
	CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToVandalismSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Vandalism' 
FROM 
	sstob..AVL_TERMINAL_SUMMARY_NO_ATM_BLACKLIST  (nolock) a inner join
	sstob..CUSTOMATMDATA (nolock) cd on a.atmkey = cd.atmkey
WHERE 
	a.summaryday >= dbo.FN_GetUTCFromUserInputTime([(FROM DATE)], [(TIME ZONE)]) 
	AND a.summaryday <= dbo.FN_GetUTCFromUserInputTime([(TO DATE)], [(TIME ZONE)]) 
	AND cd.TermId IN ([(TERMINAL BP)])


-- DETAILS
SELECT cd.TermId AS 'Terminal ID',
		Location AS Location,
		dbo.DateDuration_Format_HH_MM(sum(cast(totaltimeofopsecs AS BIGINT)), 1, 1) AS 'Total Operational Time',
        CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(InServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OutofServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Out of Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 100.00 ELSE SUM(cast(inactivesecs AS BIGINT)) * 100.00 / (SUM(cast(TotalTimeofopsecs AS BIGINT)) + SUM(cast(inactivesecs AS BIGINT))) END AS 'Inactive Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCashOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Cash Out',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToMaintenanceSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Maintenance',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Hard Faults',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'SW Faults',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSupplyOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Supply Out',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCommDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Communication Lost',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHostDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Host Down',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToVandalismSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Vandalism' 
	FROM 
		sstob..AVL_TERMINAL_SUMMARY_NO_ATM_BLACKLIST  (nolock) a inner join
		sstob..CUSTOMATMDATA (nolock) cd on a.atmkey = cd.atmkey
	WHERE 
		a.summaryday >= dbo.FN_GetUTCFromUserInputTime([(FROM DATE)], [(TIME ZONE)]) 
		AND a.summaryday <= dbo.FN_GetUTCFromUserInputTime([(TO DATE)], [(TIME ZONE)]) 
		AND cd.TermId IN ([(TERMINAL BP)]) 
	GROUP BY cd.TermId,Location;


    SELECT cd.TermId AS 'Terminal ID',
		CASE 
        	WHEN ISNULL(LTRIM(RTRIM(Location)), '') = '' THEN 'NO SE TIENE INFORMACION PROPORCIONADA'
        	ELSE Location
    	END Location,
		cd.Marca,
		cd.PROVEEDOR as 'Tipo ATM',
		cd.UBICACION_ATM as 'Ubicacion ATM (Agencia o Isla)',
		cd.NombreATM as 'Nombre ATM',
		CASE 
        	WHEN ISNULL(LTRIM(RTRIM(personincharge)), '') = '' THEN 'NO SE TIENE INFORMACION PROPORCIONADA'
        	ELSE personincharge
    	END as 'Responsable Torre',
		cd.UltimaTransaccionExitosa as 'Ultima Transaccion',
		dbo.DateDuration_Format_HH_MM(sum(cast(totaltimeofopsecs AS BIGINT)), 1, 1) AS 'Total Operational Time',
        CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(InServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OutofServiceTimeSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Out of Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 100.00 ELSE SUM(cast(inactivesecs AS BIGINT)) * 100.00 / (SUM(cast(TotalTimeofopsecs AS BIGINT)) + SUM(cast(inactivesecs AS BIGINT))) END AS 'Inactive Service %',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCashOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Cash Out',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToMaintenanceSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'In Maintenance',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Hard Faults',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSWSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'SW Faults',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToSupplyOutSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Supply Out',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToCommDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Communication Lost',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToHostDownSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Host Down',
		CASE WHEN SUM(cast(TotalTimeofopsecs AS BIGINT)) = 0 THEN 0.00 ELSE SUM(cast(OosDueToVandalismSecs AS BIGINT)) * 100.00 / SUM(cast(TotalTimeofopsecs AS BIGINT)) END AS 'Vandalism' 
	FROM 
		sstob..AVL_TERMINAL_SUMMARY_NO_ATM_BLACKLIST  (nolock) a inner join
		sstob..CUSTOMATMDATA (nolock) cd on a.atmkey = cd.atmkey
	WHERE 
		a.summaryday >= dbo.FN_GetUTCFromUserInputTime([(FROM DATE)], [(TIME ZONE)]) 
		AND a.summaryday <= dbo.FN_GetUTCFromUserInputTime([(TO DATE)], [(TIME ZONE)]) 
		AND cd.TermId IN ([(TERMINAL BP)]) 
	GROUP BY 
		cd.Marca,
		CASE 
        	WHEN ISNULL(LTRIM(RTRIM(Location)), '') = '' THEN 'NO SE TIENE INFORMACION PROPORCIONADA'
        	ELSE Location
    	END,
		cd.termid,
		cd.PROVEEDOR,
		cd.UBICACION_ATM,
		cd.NombreATM,
		CASE 
        	WHEN ISNULL(LTRIM(RTRIM(personincharge)), '') = '' THEN 'NO SE TIENE INFORMACION PROPORCIONADA'
        	ELSE personincharge
    	END,
		cd.UltimaTransaccionExitosa

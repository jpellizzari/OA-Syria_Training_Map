env.info("Navygroup Loading", false)
-------------------------------
--- Lincoln RECOVERY TANKER ---
-------------------------------

local ArcoRoosevelt=RECOVERYTANKER:New(UNIT:FindByName("CVN-72 A. Lincoln"), "Tanker_S3-B_Arco1 #IFF:(12)5017FR")
ArcoRoosevelt:SetTakeoffCold()
ArcoRoosevelt:SetTACAN(117, "ARC", "X")
ArcoRoosevelt:SetRadio(317.525, "AM")
ArcoRoosevelt:SetCallsign(2,1)
ArcoRoosevelt:Start()


-------------------------------
----- Lincoln RESCUE HELO -----
-------------------------------

local RescueheloLincoln=RESCUEHELO:New(UNIT:FindByName("CVN-72 A. Lincoln"), "Rescue_Helo #IFF:(12)5016FR")
RescueheloLincoln:SetTakeoffHot()
RescueheloLincoln:SetAltitude(60)
RescueheloLincoln:SetOffsetX(300) --left/right
RescueheloLincoln:SetOffsetZ(300) --fwd/back
RescueheloLincoln:Start()

-------------------------------
----- Tarawa RESCUE HELO -----
-------------------------------

local RescueheloTarawa=RESCUEHELO:New(UNIT:FindByName("LHA-1 Tarawa"), "Rescue_Helo #IFF:(12)5016FR")
RescueheloTarawa:SetTakeoffHot()
RescueheloTarawa:SetAltitude(60)
RescueheloTarawa:SetOffsetX(300) --left/right
RescueheloTarawa:SetOffsetZ(300) --fwd/back
RescueheloTarawa:Start()

-------------------------------
----- Kuznetsov RESCUE HELO -----
-------------------------------

local RescueheloTarawa=RESCUEHELO:New(UNIT:FindByName("Kuznetsov"), "Rescue_Helo_Red")
RescueheloTarawa:SetTakeoffHot()
RescueheloTarawa:SetAltitude(35)
RescueheloTarawa:SetOffsetX(0) --left/right
RescueheloTarawa:SetOffsetZ(-300) --fwd/back
RescueheloTarawa:Start()

------------------------
------  Navygroup ------
------------------------

Navygroup_menu = MENU_COALITION:New(coalition.side.BLUE, "Navygroup")
Navygroup_menu_red = MENU_COALITION:New(coalition.side.RED, "Navygroup")


-------------------------------
------ Lincoln Navygroup ------
-------------------------------

lincoln_menu = MENU_COALITION:New(coalition.side.BLUE, "CVN-72 A. Lincoln", Navygroup_menu)

Lincoln = GROUP:FindByName('CVN-72')
CVN72 = NAVYGROUP:New(Lincoln)
CVN72:Activate()
CVN72:SetPatrolAdInfinitum()
CVN72:Cruise(10)

function start_recovery_Lincoln()
 local shipheading72 = mist.utils.round(CVN72:GetHeadingIntoWind(-9,28),0)
 if CVN72:IsSteamingIntoWind() == true then
 Message_01 = MESSAGE:New("Lincoln is currently launching/recovering, currently active recovery window closes at time "..timerecovery_end72.." BRC is "..shipheading72, 25):ToBlue()        
else 
 local timenow72=timer.getAbsTime( )
 local timeend72=timenow72+CVN72_WindowTime*60
 local timerecovery_start72 = UTILS.SecondsToClock(timenow72,true)
  timerecovery_end72 = UTILS.SecondsToClock(timeend72,true)
  CVN72:AddTurnIntoWind(timerecovery_start72,timerecovery_end72,28,false,-9)
 Message_01 = MESSAGE:New("Lincoln is turning, Recovery Window is open from "..timerecovery_start72.." until "..timerecovery_end72.." BRC at "..shipheading72.." deg", 25):ToBlue()            
  end end
menu_recovery_1 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/15min",lincoln_menu,
 function() CVN72_WindowTime = 17 
   Message_10 = MESSAGE:New("An Lincoln recovery window has been requested for 15 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Lincoln, nil , timer.getTime() + 6)  
  end )
menu_recovery_2 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/30min",lincoln_menu,
 function() CVN72_WindowTime = 32 
   Message_20 = MESSAGE:New("An Lincoln recovery window has been requested for 30 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Lincoln, nil , timer.getTime() + 6)  
  end )
menu_recovery_3 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/60min",lincoln_menu,
 function() CVN72_WindowTime = 62 
   Message_30 = MESSAGE:New("An Lincoln recovery window has been requested for 60 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Lincoln, nil , timer.getTime() + 6)  
  end )
menu_recovery_4 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/90min",lincoln_menu,
 function() CVN72_WindowTime = 92 
   Message_40 = MESSAGE:New("An Lincoln recovery window has been requested for 90 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Lincoln, nil , timer.getTime() + 6)  
  end )
menu_recovery_5 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"END RECOVERY",lincoln_menu,
 function()
   Message_40 = MESSAGE:New("The Lincoln recovery window has been cancelled", 5):ToBlue()  
   CVN72:TurnIntoWindStop():Cruise(10)
  end )
  
 -------------------------------
------ Tarawa Navygroup ------
-------------------------------

tarawa_menu = MENU_COALITION:New(coalition.side.BLUE, "LHA-1 Tarawa", Navygroup_menu)

Tarawa = GROUP:FindByName('LHA-1 Tarawa')
LHA01 = NAVYGROUP:New(Tarawa)
LHA01:Activate()
LHA01:SetPatrolAdInfinitum()
LHA01:Cruise(10)

function start_recovery_Tarawa() 
 local shipheading01 = mist.utils.round(LHA01:GetHeadingIntoWind(-9,20),0)
 if LHA01:IsSteamingIntoWind() == true then
 Message_01 = MESSAGE:New("Tarawa is currently launching/recovering, currently active recovery window closes at time "..timerecovery_end01.." BRC is "..shipheading01, 25):ToBlue()        
else 
 local timenow01=timer.getAbsTime( )
 local timeend01=timenow01+LHA01_WindowTime*60
 local timerecovery_start01 = UTILS.SecondsToClock(timenow01,true)
  timerecovery_end01 = UTILS.SecondsToClock(timeend01,true)
  LHA01:AddTurnIntoWind(timerecovery_start01,timerecovery_end01,20,false,-9)
 Message_01 = MESSAGE:New("Tarawa is turning, Recovery Window is open from "..timerecovery_start01.." until "..timerecovery_end01.." BRC is "..shipheading01.." deg", 25):ToBlue()            
  end end
menu_recovery_1 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/15min",tarawa_menu,
 function() LHA01_WindowTime = 17 
   Message_10 = MESSAGE:New("An Tarawa recovery window has been requested for 15 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Tarawa, nil , timer.getTime() + 6)  
  end )
menu_recovery_2 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/30min",tarawa_menu,
 function() LHA01_WindowTime = 32 
   Message_20 = MESSAGE:New("An Tarawa recovery window has been requested for 30 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Tarawa, nil , timer.getTime() + 6)  
  end )
menu_recovery_3 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/60min",tarawa_menu,
 function() LHA01_WindowTime = 62 
   Message_30 = MESSAGE:New("An Tarawa recovery window has been requested for 60 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Tarawa, nil , timer.getTime() + 6)  
  end )
menu_recovery_4 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"Recovery/90min",tarawa_menu,
 function() LHA01_WindowTime = 92 
   Message_40 = MESSAGE:New("An Tarawa recovery window has been requested for 90 minutes", 5):ToBlue()  
    timer.scheduleFunction(start_recovery_Tarawa, nil , timer.getTime() + 6)  
  end )
menu_recovery_5 = MENU_COALITION_COMMAND:New( coalition.side.BLUE,"END RECOVERY",tarawa_menu,
 function()
   Message_40 = MESSAGE:New("The Tarawa recovery window has been cancelled", 5):ToBlue()  
   LHA01:TurnIntoWindStop():Cruise(10)
  end ) 
env.info("Navygroup Complete", false)

 -------------------------------
------ Kuznetsov Navygroup ------
-------------------------------

Kuznetsov_menu = MENU_COALITION:New(coalition.side.RED, "Kuznetsov", Navygroup_menu_red)

Kuznetsov = GROUP:FindByName('Kuznetsov')
KUZ01 = NAVYGROUP:New(Kuznetsov)
KUZ01:Activate()
KUZ01:SetPatrolAdInfinitum()
KUZ01:Cruise(10)

function start_recovery_Kuznetsov() 
 local shipheading01 = mist.utils.round(KUZ01:GetHeadingIntoWind(-9,28),0)
 if KUZ01:IsSteamingIntoWind() == true then
 Message_01 = MESSAGE:New("Kuznetsov is currently launching/recovering, currently active recovery window closes at time "..timerecovery_end01.." BRC is "..shipheading01, 25):ToRed()        
else 
 local timenow01=timer.getAbsTime( )
 local timeend01=timenow01+KUZ01_WindowTime*60
 local timerecovery_start01 = UTILS.SecondsToClock(timenow01,true)
  timerecovery_end01 = UTILS.SecondsToClock(timeend01,true)
  KUZ01:AddTurnIntoWind(timerecovery_start01,timerecovery_end01,28,false,-9)
 Message_01 = MESSAGE:New("Kuznetsov is turning, Recovery Window is open from "..timerecovery_start01.." until "..timerecovery_end01.." BRC is "..shipheading01.." deg", 25):ToRed()            
  end end
menu_recovery_1 = MENU_COALITION_COMMAND:New( coalition.side.RED,"Recovery/15min",Kuznetsov_menu,
 function() KUZ01_WindowTime = 17 
   Message_10 = MESSAGE:New("An Kuznetsov recovery window has been requested for 15 minutes", 5):ToRed()  
    timer.scheduleFunction(start_recovery_Kuznetsov, nil , timer.getTime() + 6)  
  end )
menu_recovery_2 = MENU_COALITION_COMMAND:New( coalition.side.RED,"Recovery/30min",Kuznetsov_menu,
 function() KUZ01_WindowTime = 32 
   Message_20 = MESSAGE:New("An Kuznetsov recovery window has been requested for 30 minutes", 5):ToRed()  
    timer.scheduleFunction(start_recovery_Kuznetsov, nil , timer.getTime() + 6)  
  end )
menu_recovery_3 = MENU_COALITION_COMMAND:New( coalition.side.RED,"Recovery/60min",Kuznetsov_menu,
 function() KUZ01_WindowTime = 62 
   Message_30 = MESSAGE:New("An Kuznetsov recovery window has been requested for 60 minutes", 5):ToRed()  
    timer.scheduleFunction(start_recovery_Kuznetsov, nil , timer.getTime() + 6)  
  end )
menu_recovery_4 = MENU_COALITION_COMMAND:New( coalition.side.RED,"Recovery/90min",Kuznetsov_menu,
 function() KUZ01_WindowTime = 92 
   Message_40 = MESSAGE:New("An Kuznetsov recovery window has been requested for 90 minutes", 5):ToRed()  
    timer.scheduleFunction(start_recovery_Kuznetsov, nil , timer.getTime() + 6)  
  end )
menu_recovery_5 = MENU_COALITION_COMMAND:New( coalition.side.RED,"END RECOVERY",Kuznetsov_menu,
 function()
   Message_40 = MESSAGE:New("The Kuznetsov recovery window has been cancelled", 5):ToRed()  
   KUZ01:TurnIntoWindStop()
   KUZ01:Surface(10)
  end ) 
env.info("Navygroup Complete", false)
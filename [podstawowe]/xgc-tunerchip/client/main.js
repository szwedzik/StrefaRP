// Variables
let isGuiOpen = false;
let defaultVehicleValues = [];
let currentVehicle = [];
let ESX = null;

emit("esx:getSharedObject", (obj) => ESX = obj);

//RegisterCommand("tuner", () => {
//  emit("xgc-tuner:openTuner")
//});

RegisterNetEvent("xgc-tuner:openTuner")
AddEventHandler("xgc-tuner:openTuner", () => {
  if (isGuiOpen) return;
  let ped = GetPlayerPed(-1);
  let vehicle = GetVehiclePedIsUsing(ped);
  // Lets check if they're the driver
  if (GetPedInVehicleSeat(vehicle, -1) === ped) {
    let vehiclePlate = GetVehicleNumberPlateText(vehicle);
    let alreadyExist = defaultVehicleValues.findIndex(e => e.plate === vehiclePlate);
    if (alreadyExist < 0) {
      currentVehicle.push({ plate: vehiclePlate, boost: 0, acceleration: 0, gearchange: 0, braking: 5, drivetrain: 5 });
      defaultVehicleValues.push({
        plate: vehiclePlate,
        fInitialDriveForce: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce"),
        fClutchChangeRateScaleUpShift: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift"),
        fClutchChangeRateScaleDownShift: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift"),
        fBrakeBiasFront: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront"),
        fDriveBiasFront: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront"),
        fInitialDragCoeff: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"),
        fLowSpeedTractionLossMult: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"),
        fDriveInertia: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia"),
      });
    }
    let tuneSettings = currentVehicle.find(e => e.plate === vehiclePlate);
    let currentHandling = defaultVehicleValues.find(e => e.plate === vehiclePlate);
    openTunerHud(tuneSettings, currentHandling)
  }
});

function openTunerHud(tune, currentHandling) {
  isGuiOpen = true;
  SetNuiFocus(true, true);
  SendNuiMessage(JSON.stringify({ type: "tunerchip-ui", display: true, tune: JSON.stringify(tune), currentHandling: JSON.stringify(currentHandling) }));
}

function applyTune(data) {
  let vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1));
  let index = defaultVehicleValues.findIndex(e => e.plate === data.plate);
  let index2 = currentVehicle.findIndex(e => e.plate === data.plate);

  // console.log(data)

  currentVehicle[index2].boost = data.uiValues.boost;
  currentVehicle[index2].acceleration = data.uiValues.acceleration;
  currentVehicle[index2].gearchange = data.uiValues.gearchange;
  currentVehicle[index2].braking = data.uiValues.braking;
  currentVehicle[index2].drivetrain = data.uiValues.drivetrain;

  if (data.uiValues.boost !== 0) {
    let defaultTractionLoss = defaultVehicleValues[index].fLowSpeedTractionLossMult;
    let newLoss = defaultTractionLoss + defaultTractionLoss * (data.boost / 20);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", data.boost);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", newLoss);

  } else {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", defaultVehicleValues[index].fInitialDriveForce);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", defaultVehicleValues[index].fLowSpeedTractionLossMult);
  }

  if (data.uiValues.boost === 0 && data.uiValues.acceleration === 0) {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia", defaultVehicleValues[index].fDriveInertia);
  } else {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia", data.acceleration);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", data.boost);
  }

  if (data.uiValues.gearchange !== 0) {
    let newDrag = (defaultVehicleValues[index].fInitialDragCoeff + (data.gearchange / 45));
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", data.gearchange)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", data.gearchange)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff", newDrag)
  } else {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", defaultVehicleValues[index].fClutchChangeRateScaleUpShift);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", defaultVehicleValues[index].fClutchChangeRateScaleDownShift);
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff", defaultVehicleValues[index].fInitialDragCoeff);
  }

  if (data.uiValues.drivetrain === 5) {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", defaultVehicleValues[index].fDriveBiasFront)
  } else {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", data.drivetrain);
  }
  
  if (data.uiValues.braking === 5) {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", defaultVehicleValues[index].fBrakeBiasFront);
  } else {
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", data.braking);
  }
}

// Close the tuner
function closeGUI() {
  isGuiOpen = false;
  SetNuiFocus(false, false);
  SendNuiMessage(JSON.stringify({ type: "tunerchip-ui", display: false }));
  ESX.UI.Menu.CloseAll() // This is incase you're using default or modified ESX Menu inventory.
}

// Close tuner callback
RegisterNuiCallbackType("closeTuner");
on("__cfx_nui:closeTuner", (data, cb) => {
  closeGUI()
  cb("ok")
});

// Save tune callback
RegisterNuiCallbackType("saveTune");
on("__cfx_nui:saveTune", (data, cb) => {
  applyTune(data);
  closeGUI()
  cb("ok")
});
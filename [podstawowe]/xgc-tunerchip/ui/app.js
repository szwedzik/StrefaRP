$(function() {

  let tune = {};
  let currentHandling = {};

  let boostSlider = $("#boostSlider");
  let accelerationSlider = $("#accelerationSlider");
  let gearSlider = $("#gearSlider");
  let brakingSlider = $("#brakingSlider");
  let drivetrainSlider = $("#drivetrainSlider")
  
  window.onload = (e) => {
    $("#container").hide();
    window.addEventListener("message", (event) => {
      let data = event.data;
      if (data !== undefined && data.type === "tunerchip-ui") {
        if (data.display === true) {
          tune = JSON.parse(data.tune);
          currentHandling = JSON.parse(data.currentHandling);

          boostSlider.val(tune.boost);
          accelerationSlider.val(tune.acceleration);
          gearSlider.val(tune.gearchange);
          brakingSlider.val(tune.braking);
          drivetrainSlider.val(tune.drivetrain);
          $("#container").show();
        } else {
          $("#container").hide();
        }
      }
    });
  }

  // Detect when [ESC] key is clicked to close Menu
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post("http://xgc-tunerchip/closeTuner", JSON.stringify({}));
    }
  };

  $("#saveButton").click(function () {
    tune.uiValues = {
      boost: JSON.parse(boostSlider.val()),
      acceleration: JSON.parse(accelerationSlider.val()),
      gearchange: JSON.parse(gearSlider.val()),
      braking: JSON.parse(brakingSlider.val()),
      drivetrain: JSON.parse(drivetrainSlider.val())
    }
    $.post("http://xgc-tunerchip/saveTune", JSON.stringify(tune));
  });

  $("#defaultTuneButton").click(function () {

    // Updating on UI
    boostSlider.val(0);
    accelerationSlider.val(0);
    gearSlider.val(0);
    brakingSlider.val(5);
    drivetrainSlider.val(5);

    // Updating object
    tune.boost = JSON.parse(calcBoost(currentHandling.fInitialDriveForce, boostSlider.val()));
    tune.acceleration = JSON.parse(calcAcc(currentHandling.fDriveInertia, accelerationSlider.val()));
    tune.gearchange = JSON.parse(calcGears(currentHandling.fClutchChangeRateScaleUpShift, gearSlider.val()));
    tune.braking = JSON.parse(calcBrakes(10, brakingSlider.val()));
    tune.drivetrain = JSON.parse(calcDriveTrain(10, drivetrainSlider.val()));

    updateCurrentValues(tune.boost, tune.acceleration, tune.gearchange, tune.braking, tune.drivetrain)
  });

    $("#sportTuneButton").click(function () {

      // Updating on UI
      boostSlider.val(10);
      accelerationSlider.val(10);
      gearSlider.val(10);
      brakingSlider.val(5);
      drivetrainSlider.val(5);

      // Updating object
      tune.boost = JSON.parse(calcBoost(currentHandling.fInitialDriveForce, boostSlider.val()));
      tune.acceleration = JSON.parse(calcAcc(currentHandling.fDriveInertia, accelerationSlider.val()));
      tune.gearchange = JSON.parse(calcGears(currentHandling.fClutchChangeRateScaleUpShift, gearSlider.val()));
      tune.braking = JSON.parse(calcBrakes(10, brakingSlider.val()));
      tune.drivetrain = JSON.parse(calcDriveTrain(10, drivetrainSlider.val()));

      updateCurrentValues(tune.boost, tune.acceleration, tune.gearchange, tune.braking, tune.drivetrain)
    });


  boostSlider.on("input", (event) => {
    let newBoost = calcBoost(currentHandling.fInitialDriveForce, $(event.target).val());
    tune.boost = newBoost;
    $("#currentBoost").html(newBoost);
  });

  accelerationSlider.on("input", (event) => {
    let newAcceleration = calcAcc(currentHandling.fDriveInertia, $(event.target).val());
    tune.acceleration = JSON.parse(newAcceleration);
    $("#currentAcceleration").html(newAcceleration);
  });

  gearSlider.on("input", (event) => {
    let newGearChange = calcGears(currentHandling.fClutchChangeRateScaleUpShift, $(event.target).val());
    tune.gearchange = JSON.parse(newGearChange);
    $("#currentGearChange").html(newGearChange);
  });

  brakingSlider.on("input", (event) => {
    let newBraking = calcBrakes(10, $(event.target).val());
    tune.braking = JSON.parse(newBraking);
    $("#currentBraking").html(newBraking);
  });

  drivetrainSlider.on("input", (event) => {
    let newDriveTrain = calcDriveTrain(10, $(event.target).val());
    tune.drivetrain = JSON.parse(newDriveTrain);
    $("#currentDriveTrain").html(newDriveTrain);
  });
});

function calcBoost(def, newVal) {
  return def + def * (newVal / 200)
}

function calcAcc(def, newVal) {
  return def + def * (newVal / 30)
}

function calcGears(def, newVal) {
  return newVal;
}

function calcBrakes(def, newVal) {
  return newVal / 10;
}

function calcDriveTrain(def, newVal) {
  return newVal / 10;
}

function updateCurrentValues(boost, acc, gear, brakes, drivetrain) {
    $("#currentBoost").html(boost);
    $("#currentAcceleration").html(acc);
    $("#currentGearChange").html(gear);
    $("#currentBraking").html(brakes);
    $("#currentDriveTrain").html(drivetrain);
}
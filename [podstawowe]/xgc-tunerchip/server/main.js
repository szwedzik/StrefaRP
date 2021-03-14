let ESX = null;

let checkESX = setInterval(() => {
  if (ESX === null) {
    emit("esx:getSharedObject", (obj) => ESX = obj);
    ESX.RegisterUsableItem("tunerchip", (source) => {
      emitNet("xgc-tuner:openTuner", source)
    });
    clearInterval(checkESX);
  }
}, 500);
//accelorometer listener
class AccelerometerListener implements SensorEventListener {
  //update x y z when new sensor data is recieved
  public void onSensorChanged(SensorEvent event) {
    ax = event.values[0];
    ay = event.values[1];
    az = event.values[2];
  }
  //clear SensorEventListener's onAccuracyChanged method (don't need it)
  public void onAccuracyChanged(Sensor acc, int accuracy) {
  }
}

//register listener on android only when in use to avoid unnecessary battery usage
public void onResume() {
  super.onResume();
  //only register listener if manager exists
  if (accManager != null) {
    accManager.registerListener(accListener, acc, SensorManager.SENSOR_DELAY_GAME);
  }
}

//unregister listener on android pause to avoid unnecessary battery usage
public void onPause() {
  super.onPause();
  //only unregister listener if manager exists
  if (accManager != null) {
    accManager.unregisterListener(accListener);
  }
}

//use sensor API to obtain context of activity containing the sketch (I literally copied this off Processing 4 Android's website, don't ask)
public void setupAccelorometer() {
  accContext = getActivity();
  accManager = (SensorManager)accContext.getSystemService(Context.SENSOR_SERVICE);
  acc = accManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  accListener = new AccelerometerListener();
  accManager.registerListener(accListener, acc, SensorManager.SENSOR_DELAY_GAME);
}
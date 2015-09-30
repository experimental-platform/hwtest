package main

import (
  "io"
  log "github.com/Sirupsen/logrus"
  "github.com/jacobsa/go-serial/serial"
  "time"
)

func sleepNow() {
  time.Sleep(time.Second)
}

func main() {
  options := serial.OpenOptions{
      PortName: "/dev/ttyUSB0",
      BaudRate: 9600,
      DataBits: 8,
      StopBits: 1,
      ParityMode: serial.PARITY_NONE,
      MinimumReadSize: 4,
    }

  port, err := serial.Open(options)
    if err != nil {
      log.Fatalf("serial.Open: %v", err.Error())
    }

  buffer := make([]byte, 12)
  _, err = io.ReadAtLeast(port, buffer, 12)
  if err != nil {
    log.Fatalf("io.ReadAtLeast: %v", err.Error())
  }

  log.Infof("Data read: %+v", buffer)
}

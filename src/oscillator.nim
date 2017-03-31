import common
import math
import util

import osc
import filter
import env
import master

type
  Oscillator = ref object of Machine
    osc: Osc

{.this:self.}

method init(self: Oscillator) =
  procCall init(Machine(self))

  nInputs = 3
  nOutputs = 1
  stereo = false
  name = "osc"


  osc.kind = Saw
  osc.pulseWidth = 0.5

  self.globalParams.add([
    Parameter(name: "freq", kind: Float, min: 0.0, max: 20000.0, default: 440.0, onchange: proc(newValue: float, voice: int) =
      self.osc.freq = newValue
    ),
    Parameter(name: "phase", kind: Float, min: 0.0, max: 1.0, default: 0.5, onchange: proc(newValue: float, voice: int) =
      self.osc.phase = newValue
    ),
    Parameter(name: "kind", kind: Int, min: 0.0, max: 4.0, default: 0.0, onchange: proc(newValue: float, voice: int) =
      self.osc.kind = newValue.int.OscKind
    ),
  ])

  setDefaults()

method process(self: Oscillator) =
  outputSamples[0] = osc.process()

proc newOscillator(): Machine =
  result = new(Oscillator)
  result.init()

registerMachine("osc", newOscillator, "basic")

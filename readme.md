# exp 4

## `core.v`

The core of this stopwatch, undertaking the function of counting.

### inputs

- `clk : wire`

  Syn-clock input.

- `rstn : wire`

  Reset signal interface. Initial the stopwatch at 0:00:00 with status of `pause`.

- `start : wire`

  Start the stopwatch, the count would increase along with time.

- `pause : wire`

  Stop the count.

- `reset : wire`

  Clear the time to 0:00:00 and stop the watch.

### outputs

- `current : reg[15:0]`

  Store the current time with the unit of 10ms from `0x0000` to `0x2EDF`, and `0xFFFF` stands for overflow error. At `error` status, the stopwatch would switch to `stop` status with `current` equals to `0x0000` for any inputs.


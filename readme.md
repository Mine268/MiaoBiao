# exp 4

## `core.v`

秒表的核心，实现计时、暂停、清零的任务。

### inputs

- `clk : wire`

  同步时钟时入，注意分频。

- `rstn : wire`

  时间清零，状态转换为暂停状态。

- `start : wire`

  开始计时，直到溢出。

- `pause : wire`

  暂停计时。

- `reset : wire`

  时间清零，状态转换为暂停状态。

### outputs

- `current : reg[15:0]`

  表示当前时间，1时间单位表示10毫秒，最大时间为`0x2EDF`，到达最大时间后转换为`0xFFFF`表示溢出。

## `freq_div.v`

分频器。

### inputs

- `clk : wire`

  同步时钟信号。

- `rst : wire`

  分频器清零。

### outputs

- `enable : reg`

  分频后的输出信号。

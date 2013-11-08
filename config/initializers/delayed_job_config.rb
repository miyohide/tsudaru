Delayed::Worker.destroy_failed_jobs = false  # 失敗してもジョブは消さない
Delayed::Worker.sleep_delay = 5  # ジョブ開始までの待ち時間（秒数）
Delayed::Worker.max_attempts = 3  # 最大試行回数


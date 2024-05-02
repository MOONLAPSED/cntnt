CREATE TABLE environment_data (
  id INTEGER PRIMARY KEY,
  DATABASE_URL TEXT,
  ENV_session_id TEXT,
  ENV_ip TEXT,
  ENV_port TEXT,
  ENV_worker_status TEXT,
  ENV_workerid TEXT,
  ENV_task_status TEXT,
  ENV_taskid TEXT
);

CREATE TABLE environment_lists (
  id INTEGER PRIMARY KEY,
  ENV_DICT TEXT,
  ENV_KEYS TEXT,
  ENV_VALUES TEXT,
  ENV_VECTORS TEXT,
  ENV_VECTORS_VALUES TEXT,
  ENV_credentials TEXT,
  ENV_embeddings TEXT,
  ENV_entbeddings TEXT
  ENV_promises TEXT
);

CREATE TABLE environment_ids (
  id INTEGER PRIMARY KEY,
  process_id INTEGER,
  thread_id INTEGER,
  tstatus_id INTEGER,
  pstatus_id INTEGER,
  thread_process_status TEXT,
  dev_ids TEXT,
  inodes_id TEXT,
  inodes_keys TEXT,
  inodes_values TEXT,
  inodes_vectors TEXT,
  inodes_vectors_values TEXT,
);
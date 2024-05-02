/* SQL DB API SPEC FOR LLM cntnt and cntnt_dtb (content and content database) by printzn@github MIT license
=================================================================================
Entity - A data model that defines the system, with relationships to other entities. An entity is not an instance of an object, but rather a definition or blueprint.

Attribute - A specific data point that an entity defines itself as having. Examples include the "dog" entity, which has attributes such as having four legs and being carnivorous, as well as unique attributes for individual iterations.

Iteration - An instance of an entity created based on the entity's definition and attributes, representing a specific object, event, or concept in the real world that can be represented with the available data types. Iterations can be categorized and modeled by entities.

Data Types - The available data types are:

- TEXT - a string of text
- INTEGER - a whole number
- REAL - a decimal number
- BLOB - a binary large object or a file that is too big to fit in a single column
- VARCHAR(255) - a restricted-length char

Nucleus Tables - The nucleus tables for the vanilla SQLite3 db are:

- text_entries - A table containing information about text entries, including the text entry name, file name, file path, file type, and text entry ID (primary key).
- embeddings - A table containing information about embeddings, including the embedding ID, model ID, and vector (primary key).
- models - A table containing information about models, including the model ID, model name, and model description.
- unix_filesystem - A table containing information about the Unix filesystem, including the inode, pathname, filetype, permissions, owner, group ID, size, mtime, and atime.
=================================================================================
*/

-- TABLES_REF:
    -- agent_affiliation
    -- agent_implication
    -- agent_inference
    -- agent_requirement
    -- agent_text_entries
    -- bool_when  
    -- bytes_agent
    -- bytes_when
    -- bytes_works
    -- cli_payloads
    -- credentials
    -- embeddings
    -- entity_embedding
    -- entity_key
    -- exe_when
    -- models
    -- nfs_mounts
    -- printf_when
    -- printf_works
    -- process_status
    -- tcp_sessions
    -- text_entries
    -- text_tags
    -- thread_process_status
    -- unix_filesystem
    -- utime_value_table


-- Agent Affiliation Table - Arbitrary runtime NLP
CREATE TABLE agent_affiliation (
  agent_id INTEGER,
  affiliation_id INTEGER,
  affiliation TEXT NOT NULL,
  PRIMARY KEY (agent_id, affiliation_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- Agent Implication Table - Arbitrary runtime NLP
CREATE TABLE agent_implication (
  agent_id INTEGER,
  implication_id INTEGER,
  implication TEXT NOT NULL,
  PRIMARY KEY (agent_id, implication_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- Agent Inference Table - Arbitrary runtime NLP
CREATE TABLE agent_inference (
  agent_id INTEGER,
  inference_id INTEGER,
  inference TEXT NOT NULL,
  PRIMARY KEY (agent_id, inference_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)  
);

-- Agent Requirement Table - Arbitrary+required runtime NLP aka agent_expectations
CREATE TABLE agent_requirement (
  agent_id INTEGER,
  requirement_id INTEGER,
  requirement TEXT NOT NULL,
  PRIMARY KEY (agent_id, requirement_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)   
);

-- Agent Text Entries Table
CREATE TABLE agent_text_entries (
  agent_id INTEGER,
  text_id INTEGER,
  PRIMARY KEY (agent_id, text_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
  FOREIGN KEY (text_id) REFERENCES text_entries(text_entry_id)
);

-- Boolean When Table
CREATE TABLE bool_when (
  bool_when_id INTEGER PRIMARY KEY,
  bool_when_desc TEXT,
  bool_string_id INTEGER UNIQUE,
  FOREIGN KEY (bool_string_id) REFERENCES bool_string_table(bool_string_id)
);

-- Bytes Agent Table - embeddings or binary payloads
CREATE TABLE bytes_agent (
  agent_id INTEGER,
  bytes_id INTEGER,
  bytes_when INTEGER,  
  PRIMARY KEY (agent_id, bytes_id),
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
  FOREIGN KEY (bytes_id) REFERENCES bytes_entries(bytes_id),
  FOREIGN KEY (bytes_when) REFERENCES bytes_entries(bytes_id) 
);

-- Bytes When Table  - binary payloads with no logic/agentic behavior
CREATE TABLE bytes_when (
  bytes_when_id INTEGER PRIMARY KEY,
  bytes_when_desc TEXT,
  bytes_string_id INTEGER UNIQUE,
  FOREIGN KEY (bytes_string_id) REFERENCES bytes_string_table(bytes_string_id)
);

-- Bytes Works Table - binary payload debug
CREATE TABLE bytes_works (
  bytes_works_id INTEGER PRIMARY KEY,
  bytes_works_desc TEXT,
  bytes_string_id INTEGER UNIQUE,
  FOREIGN KEY (bytes_string_id) REFERENCES bytes_string_table(bytes_string_id)
);

-- CLI Payloads Table
CREATE TABLE cli_payloads (
  id INTEGER PRIMARY KEY,
  payload BLOB NOT NULL
);

-- Credentials Table
CREATE TABLE credentials (
  credential_id INTEGER PRIMARY KEY,
  agent_id INTEGER,
  credential TEXT,
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)  
);

-- Embeddings Table
CREATE TABLE embeddings (
  embedding_id INTEGER PRIMARY KEY,
  model_id INTEGER NOT NULL,
  vector BLOB NOT NULL,
  FOREIGN KEY (model_id) REFERENCES models(model_id)
);

-- Entity Embedding Table - all iterations are entities but entbeddings are not entities nor iterations, they are binary payloads
CREATE TABLE entity_embedding (
  entbedding_id INTEGER PRIMARY KEY,
  entbedding_desc TEXT,
  entbed_id INTEGER UNIQUE,
  FOREIGN KEY (entbed_id) REFERENCES entbed_table(entbed_id)
);  

-- Entity Key Table
CREATE TABLE entity_key (
  entkey_id INTEGER PRIMARY KEY,
  entkey_desc TEXT,
  entkey_string_id INTEGER UNIQUE,
  FOREIGN KEY (entkey_string_id) REFERENCES entkey_string_table(entkey_string_id)
);

-- Executable When Table - executable runtime behaviors
CREATE TABLE exe_when (
  exe_when_id INTEGER PRIMARY KEY,
  exe_when_desc TEXT,
  exe_string_id INTEGER UNIQUE,
  FOREIGN KEY (exe_string_id) REFERENCES exe_string_table(exe_string_id)
);

-- Models Table
CREATE TABLE models (
  model_id INTEGER PRIMARY KEY,
  model_name TEXT NOT NULL,
  model_description TEXT
);

-- NFS Mounts Table
CREATE TABLE nfs_mounts (
  id INTEGER PRIMARY KEY,
  server TEXT NOT NULL,
  mountpoint TEXT NOT NULL,
  options TEXT  
);

-- Printf When Table - agentic or logical utf8 payloads
CREATE TABLE printf_when (
/*  printf_when_id INTEGER PRIMARY KEY, */
  printf_when_desc TEXT,
  printf_string_id INTEGER UNIQUE,
  printf_id INTEGER PRIMARY KEY, 
  printf_time DATETIME NOT NULL
  FOREIGN KEY (printf_string_id) REFERENCES printf_string_table(printf_string_id)
);

-- Printf Works Table - print string debug
CREATE TABLE printf_works (
  printf_works_id INTEGER PRIMARY KEY,
  printf_works_desc TEXT,
  printf_bytes_id INTEGER UNIQUE,
  FOREIGN KEY (printf_bytes_id) REFERENCES printf_bytes_table(printf_bytes_id)
);
  
-- Process Status Table - threading + multi-tasking + async ops values
CREATE TABLE process_status (
  process_id INTEGER NOT NULL,
  tstatus_id INTEGER NOT NULL,
  PRIMARY KEY (process_id, tstatus_id)
);

-- TCP/IP Sessions Table
CREATE TABLE tcp_sessions (
  session_id INTEGER PRIMARY KEY,
  ip TEXT NOT NULL, 
  port INTEGER NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME 
  id INTEGER PRIMARY KEY,
  local_address TEXT NOT NULL,
  local_port INTEGER NOT NULL,
  remote_address TEXT NOT NULL,
  remote_port INTEGER NOT NULL,
  state TEXT NOT NULL
);

-- Text Entries Table - all entities/entries require either a text entry or a multimedia entry that represent files in a vitualized gnu linux environment, not tables in a db
CREATE TABLE text_entries (
  text_entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
  text_entry_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  file_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  file_path VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  file_type VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL  
);

-- Text Tags Table - can I do this without "SELECT * FROM"? It would be nice, for back-propogation @ runtime
CREATE TABLE text_tags (
  text_id INTEGER,
  tag_id INTEGER,
  PRIMARY KEY (text_id, tag_id),
  FOREIGN KEY (text_id) REFERENCES text_entries(text_entry_id), 
  FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);
  
-- Thread Process Status Table
CREATE TABLE thread_process_status (
  process_id INTEGER NOT NULL,
  tstatus_id INTEGER NOT NULL,
  PRIMARY KEY (process_id, tstatus_id),
  FOREIGN KEY (process_id) REFERENCES text_entries(text_entry_id)  
);

-- Unix Filesystem Table
CREATE TABLE unix_filesystem (
  inode INTEGER PRIMARY KEY,
  pathname TEXT NOT NULL,
  filetype TEXT NOT NULL,
  permissions TEXT NOT NULL,
  owner INTEGER NOT NULL,
  group_id INTEGER NOT NULL,
  size INTEGER NOT NULL,
  mtime INTEGER NOT NULL,
  atime INTEGER NOT NULL
);

-- utime Value Table - utime is mtime and/or atime and or the most-recently (~1000ms) cached value of utime
CREATE TABLE utime_value_table (
  utime_value_id INTEGER PRIMARY KEY,
  utime_value_desc VARCHAR(255),
  FOREIGN KEY (utime_value_id) REFERENCES text_entries(text_entry_id)
);

/*
Let's delve deeper into the concepts of Iterations and Relationships in the context of your database schema.

1. Iterations:

In your project directive, you've defined an "Iteration" as a real-world concept, object, event, or anything that can be represented using the data types at your disposal. In a relational database, each row in a table represents a unique iteration of the associated entity. Here's a detailed explanation along with some fenced-code examples:

a. Iteration as Rows:

Consider the text_entries table in your schema. Each row in this table represents a distinct text entry, and this aligns with the concept of "Iteration." Let's explore this with a fenced-code example:

-- Creating a sample text_entries table
CREATE TABLE text_entries (
  text_entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
  text_entry_name VARCHAR(255) NOT NULL,
  content TEXT NOT NULL
);

-- Inserting a few text entries (Iterations)
INSERT INTO text_entries (text_entry_name, content) VALUES ('Text Entry 1', 'This is the content of Text Entry 1');
INSERT INTO text_entries (text_entry_name, content) VALUES ('Text Entry 2', 'Content for Text Entry 2');

In this example, each row in the text_entries table represents a unique "Iteration" of a text entry, and you can retrieve, modify, or delete individual iterations based on their primary keys (text_entry_id).

2. Relationships:

Managing relationships between entities is a fundamental aspect of a relational database. Let's consider how you can implement and work with relationships within your database schema:

a. Foreign Keys for Relationships:

In your schema, you mentioned entities like "process_status" and "thread_process_status." To establish relationships between these entities, you can use foreign keys. Each of these tables can reference the primary key of the other, indicating their relationship. Here's a code example:

-- Creating a sample process_status table
CREATE TABLE process_status (
  process_id INTEGER PRIMARY KEY,
  status_description TEXT
);

-- Creating a sample thread_process_status table with a foreign key relationship
CREATE TABLE thread_process_status (
  thread_id INTEGER PRIMARY KEY,
  process_id INTEGER, -- Foreign key to relate this to process_status
  status_description TEXT,
  FOREIGN KEY (process_id) REFERENCES process_status(process_id)
);

In this example, the thread_process_status table has a foreign key column (process_id) that establishes a relationship with the process_status table. It ensures that each row in the thread_process_status table is associated with a specific process status, creating a meaningful relationship between entities.

b. Querying Relationships:

To query data involving relationships, you can use SQL JOIN operations. These allow you to combine information from multiple tables based on shared keys. For example, to retrieve information about threads along with their associated process statuses, you can use a SQL JOIN like this:

SELECT thread_process_status.thread_id, thread_process_status.status_description, process_status.status_description AS process_status
FROM thread_process_status
JOIN process_status ON thread_process_status.process_id = process_status.process_id;

This query combines data from the thread_process_status and process_status tables, providing a result set that includes both thread-specific and associated process status information.

By embracing the relational model, you can effectively represent complex data relationships and query them to extract meaningful insights from your database. It's a powerful paradigm that enables you to organize, manage, and analyze data in a structured and efficient manner.
*/

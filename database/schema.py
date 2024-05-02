# Define the abstract base class
class Entity:
    def __init__(self, name, description):
        self.name = name
        self.description = description

    def __str__(self):
        return self.name

# Define the concrete subclasses
class Attribute(Entity):
    def __init__(self, name, type):
        super().__init__(name, "Attribute of {}".format(name))
        self.type = type

    def __str__(self):
        return "{}: {}".format(self.name, self.type)

class Iteration(Entity):
    def __init__(self, name, description):
        super().__init__(name, description)

    def __str__(self):
        return self.name

# Define the specific data types as subclasses of Attribute
class TEXT(Attribute):
    def __init__(self, name):
        super().__init__(name, "TEXT")

    def __str__(self):
        return "{}: TEXT".format(self.name)

class INTEGER(Attribute):
    def __init__(self, name):
        super().__init__(name, "INTEGER")

    def __str__(self):
        return "{}: INTEGER".format(self.name)

class REAL(Attribute):
    def __init__(self, name):
        super().__init__(name, "REAL")

    def __str__(self):
        return "{}: REAL".format(self.name)

class BLOB(Attribute):
    def __init__(self, name):
        super().__init__(name, "BLOB")

    def __str__(self):
        return "{}: BLOB".format(self.name)

class VARCHAR(Attribute):
    def __init__(self, name, length):
        super().__init__(name, "VARCHAR({})".format(length))
        self.length = length

    def __str__(self):
        return "{}: VARCHAR({})".format(self.name, self.length)

# Define the specific data types as subclasses of Iteration
class TextEntry(Iteration):
    def __init__(self, name, text):
        super().__init__(name, "Text entry")
        self.text = text

    def __str__(self):
        return "{}: {}".format(self.name, self.text)

class Embedding(Iteration):
    def __init__(self, name, model, vector):
        super().__init__(name, "Embedding")
        self.model = model
        self.vector = vector

    def __str__(self):
        return "{}: {}".format(self.name, self.model)

class Model(Iteration):
    def __init__(self, name, model_name, model_description):
        super().__init__(name, "Model")
        self.model_name = model_name
        self.model_description = model_description

    def __str__(self):
        return "{}: {}".format(self.name, self.model_name)

class UnixFilesystem(Iteration):
    def __init__(self, inode, pathname, filetype, permissions, owner, group_id, size, mtime, atime):
        super().__init__(inode, "Unix filesystem")
        self.pathname = pathname
        self.filetype = filetype
        self.permissions = permissions
        self.owner = owner
        self.group_id = group_id
        self.size = size
        self.mtime = mtime
        self.atime = atime

    def __str__(self):
        return "{}: {}".format(self.inode, self.pathname)

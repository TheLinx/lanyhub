require("anyhub")

io.write("Enter the full path for the file you wish to upload: ") io.flush()
file_to_upload = assert(io.read("*l"))

vars = {}

io.write("Do you wish to upload as a user? [y/N] ") io.flush()
if (io.read("*l") or ""):lower() == "y" then
  io.write("Username: ") io.flush()
  vars.username = assert(io.read("*l"))
  io.write("Password: ") io.flush()
  vars.password = assert(io.read("*l"))
end

io.write("Do you wish to mark your file as private? [y/N] ") io.flush()
if (io.read("*l") or ""):lower() == "y" then
  vars.private = "true"
end

io.write("Do you wish to manually specify a mimetype? [y/N] ") io.flush()
if (io.read("*l") or ""):lower() == "y" then
  io.write("Mimetype: ") io.flush()
  vars.mimetype = assert(io.read("*l"))
end

io.write("Uploading... ") io.flush()

result = anyhub.upload(file_to_upload, vars)
-- We should probably do error handling here.
print("Done! URL: " .. result.url)

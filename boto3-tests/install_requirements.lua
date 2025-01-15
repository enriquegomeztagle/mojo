local file = io.open("requirements.txt", "r")
if file then
	for line in file:lines() do
		if line ~= "" then
			print("Installing " .. line .. "...")
			os.execute("conda install -y conda-forge::" .. line)
		end
	end
	file:close()
	print("All packages installed!")
else
	print("Error: Could not open requirements.txt")
end

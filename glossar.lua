
datafile = "glossar.data"
if arg[1]~= nil then datafile=arg[1] end

outfile = "glossar.md"
if arg[2]~= nil then outfile=arg[2] end


local glossary = {}      -- a set to collect & sort glossary terms

function Entry (g)
  glossary[g.term] = {
		mean=g.meaning,
		full=g.expanded,
		alt=g.alternates,
		scope=g.scope
	}
end

if io.open (datafile,"r") ~= nil then
	dofile(datafile)

	local sortTable = {}
	for k,v in pairs(glossary) do table.insert(sortTable, k) end
	table.sort(sortTable,function(a,b) return string.lower(a)<string.lower(b) end)

	io.output(outfile)
	for k, v in ipairs(sortTable) do
		link = v
		link = string.gsub(link,"%c","_")
		link = string.gsub(link,"%s","_")
		link = string.gsub(link,"%p","_")
		io.write("##### ",v,"  ")
		if glossary[v].full ~= nil then io.write("_(",glossary[v].full,")_") end
		io.write("{#",link,"}\n")
		if glossary[v].alt ~= nil then io.write(" (",glossary[v].alt,") ") end
		if glossary[v].mean ~= nil then io.write(" ",glossary[v].mean," ") end
		if glossary[v].scope ~= nil then io.write("[",glossary[v].scope,"]") end
		io.write("\n  \n")
	end
else
	print ("Glossary data input not found: ",datafile)
end

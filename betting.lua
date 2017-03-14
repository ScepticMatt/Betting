patha = "horses.tsv"
pathb = "table.tsv"

-- reads two-column tsv into lua table
function read_data(filename)
  local file = io.open(filename)
  local data = {}
  
  if file then
    for line in file:lines() do
      local name, bet = line:match("([^	]+)	([^	]+)")
      local struct = {name, tonumber(bet)}
      table.insert (data, struct)
    end
  end
  return data
end

-- read general tsv into lua table
function read_tsv(filename)
  local file = io.open(filename)
  local data = {}
  print (io.open(filename))
  if file then
    for line in file:lines() do
      local struct2 = {} -- valuea valueb valuec ...
      local index = 1;
      -- split string by tabulator
      for value in string.gmatch(line, '([^	]+)') do
        struct2[index] = value
        index= index + 1
      end
      table.insert (data, struct2)
    end
  end
  return data
end

-- line-by line, adds bets together
function calculate_total(table)
  local count = 0
  for index, struct in next,data,nil do count = count + struct[2] end
  return count
end

-- prints betting table in tsv format
function print_table(table)
  for index, struct in next,table,nil do print(struct[1] .. "	" .. struct[2]) end
end

-- prints cindex-th line
function print_column(table, cindex)
  for index, struct2 in next,table,nil do print(struct2[tonumber(cindex)]) end
end


-- print the distinct values from the cindex-th column, along with the number of times each occurs.
function print_distinct(table, cindex)
    local struct3 = {}  -- [item, count]
    local data2 = {} -- list of struct3 
    -- get n'th column value
    for index, struct2 in next,table,nil do 
       local newitem = struct2[tonumber(cindex)]
       -- look for item in table 2, increase count if found, else add
       local found = false
       for index2, struct3 in next,table2,nil do
          if struct3[1] == newitem then
            struct3[2] = struct3[2] + 1
            found = true
            break
          end
       end
       
       -- insert new if applicable
       if (found ~= true) 
        struct3 = {newitem, 1}
        table.insert(data2, struct3)
       end
    end
    -- print 
    for index, struct3 in next,table,nil do
      struct3[1] .. "	" .. struct3[2]
    end
end
    
-- Coding 1
data = read_data(patha)
count = calculate_total(data)
print ("Total bets = " .. count)

-- Coding 2
table.sort(data, function(a,b) return a[2]>b[2] end)
print_table(data)

-- Coding 3
data = read_tsv(pathb)
print_column(data, 3)

-- Coding 4
data = read_tsv(pathb)
print_distinct(data)

# importing all liberay
import re

# all required keywords
keywords = ["if", "then", "else", "int", "return","float"]

# reading files
model = open("Test_code.cc","r")
# model = open("simple.cc","r")
model_str=model.read()

# finding all comments
str1 = re.findall("[/*].*[*/]",model_str)

# replacing all comments to " " 
for commet in str1:
	model_str = model_str.replace(commet,'')

# reading all words except numericals
str2 = re.findall("[_a-zA-Z]\w*",model_str)
#print(a2,"a2\n")

# removing all duplicates
str2 = list(set(str2))
for i in str2:
	if i in keywords:
		print(i,"\t\tkeyword")

	else:
		print(i,"\t\tidentifier")

# reading all numerical word
str3 = re.findall("\W\d\d*[.]?\d*",model_str)

# removing all duplicates
str3 = list(set(str3))

for numeril in str3:
	if(numeril[0] == "-"):
		print(numeril,"\t\tnumerical")
	else:
		print(numeril[1:],"\t\tnumerical")

print("\nSymbol table is as given below :")

for i in str2:
	if i not in keywords:
			first_occur = re.search(i,model_str)
			first_occur_index = first_occur.start()
			if model_str[first_occur_index-3] == "a":
				type_check = "float"
			else:
				type_check = "int"
			print(i,"\t",type_check)

model.close()

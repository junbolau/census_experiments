import ast

FILE_NAME = "./data/with_genus_plane_quintic_unfiltered_batch_"

for i in range(25):
    ACTUAL_FILE_NAME = FILE_NAME + str(i) + ".txt"
    with open(ACTUAL_FILE_NAME, 'r') as fp:
        tmp = []
        for line in fp:
            line0 = ast.literal_eval(line)
            try:
                if line0[0] == tmp[-1][0]:
                    tmp[-1][1].append(line0[1])
                else:
                    tmp.append([line0[0],[line0[1]]])
            except:
                tmp.append([line0[0],[line0[1]]])
        with open("./sorted_data/with_genus_plane_quintic_unfiltered_batch_" + str(i) + ".txt",'w') as f:
            f.write(str(tmp) + "\n")
            f.close()
        fp.close()

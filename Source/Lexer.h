typedef struct {
	unsigned code = code;
	unsigned char* payload;
	unsigned rangeStart;
	unsigned rangeLength;
	
};

void brulee_lex_tokenize(std::string& input, std::vector<brulee_token>& tokens);

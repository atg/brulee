import Text.ParserCombinators.Parsec
import Control.Applicative

-- Program
pProgram :: GenParser HToken st Program
pProgram = do
	decls <- many pDecl
	eof
	return decls

-- Decl
pDecl = pClassDecl <|> pFunctionDecl

-- Block ::= '{' Stmt+ '}'
pBlock = pTok LCURLY *> many pStmt <* pTok RCURLY

-- Stmt ::= FunctionCall | Assignment
pStmt = pFunctionCall <|> pAssignment

-- Assignment ::= lvalue '=' exprs
pAssignment = pLvalue

-- Tuple

-- Expr

-- Type

-- Lvalue

-- FunctionCall

-- MessageSend

-- Selector

-- ScopedIdent

-- Ident


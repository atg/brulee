-- In an effort to remain DRY-compliant, multiple elements in data declarations are hereby prohibited in the AST. Use tuples instead, which can be transparently factored out into a type if needed. They also have the benefit of being a first-class citizen in Haskell, so you don't have to always unpack them.
--   YES: FunctionCall (ScopedIdent, Tuple)
--    NO: FunctionCall ScopedIdent Tuple

-- If that offends you, please close this file and watch this video instead: http://www.youtube.com/watch?v=-efQuSlxgWY


-- A program is a sequence of declarations
type Program = [Decl]

-- A declaration is a compile-time modification of the program
data Decl = {
	ClassDecl ClassDecl |
	FunctionDecl FunctionDecl
}

-- A block is a sequence of statements
type Block = [Stmt]

-- A statement is a run-time modification of state
data Stmt = {
	FunctionCall FunctionCall |
	Assignment (Lvalue, Tuple)
}

-- A tuple is a sequence of expressions
type Tuple = [Expr]

-- An expression is a run-time transformation of an input
-- All expressions have type information associated with them, even if their type is Unknown
type Expr = (Type, UntypedExpr) 
data UntypedExpr = {
	FunctionCall FunctionCall |
	Operation (String, Expr, Expr) |
	Tuple Tuple
}

data Type = {
	Unknown |
	-- We include a type with nil, so that Complement is an involution
	Nil Type |
	Zero Type |
	NotNil Type |
	NotZero Type |
	IsOfClass ScopedIdent |
	HasSelector Selector |
	Union Type |
	Intersection Type |
	Complement Type
}

-- An Lvalue is a path to scope
-- There is no type Lvalues = [Lvalue] since that would correspond to ListDestructure
data Lvalue = {
	Ident ScopedIdent |
	PointerDereference Lvalue |
	Subscript (Lvalue, Expr) |
	ListDestructure [Lvalue] |
	DictionaryDestructure [(String, Lvalue)]
}

type FunctionCall = (ScopedIdent, Tuple)
type MessageSend = (Selector, Tuple)

-- Selectors are stored as a list of segments
type Selector = [String]

-- An ident that has been namespaced
type ScopedIdent = [Ident]
-- An ident that may _not_ be namesapced
type Ident = String

module AdaptExt

using ProtectedArrays
import Adapt: adapt_structure

adapt_structure(to, pa::ProtectedArray) = protect(adapt(to, parent(x)))

end

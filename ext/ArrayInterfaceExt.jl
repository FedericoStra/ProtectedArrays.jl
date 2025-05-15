module ArrayInterfaceExt

using ProtectedArrays
import ArrayInterface: can_setindex, ismutable, is_forwarding_wrapper, parent_type

can_setindex(@nospecialize T::Type{<:ProtectedArray}) = false
ismutable(@nospecialize T::Type{<:ProtectedArray}) = false

is_forwarding_wrapper(@nospecialize T::Type{<:ProtectedArray}) = true
parent_type(@nospecialize T::Type{<:ProtectedArray}) = fieldtype(T, :parent)

end

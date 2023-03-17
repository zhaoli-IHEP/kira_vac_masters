
# rmax: the maximal sum of positive propagator powers in the seed.
# smax: the maximal negative sum of negative propagator powers in the seed.

##########################
function generate_lists( 
    n::Int64, 
    r_max::Int64, 
    s_max::Int64 
)::Vector{Vector{Int64}}
##########################

  if n == 1

    indices_list = Vector{Vector{Int64}}()
    for index in (-s_max):r_max
      push!( indices_list, [index] )
    end # for index
    return indices_list

  else

    indices_list = Vector{Vector{Int64}}()
    for index in (-s_max):r_max

      if index >= 0
        sub_indices_list = generate_lists( n-1, r_max-index, s_max )
      else # index < 0
        sub_indices_list = generate_lists( n-1, r_max, s_max-abs(index) )
      end # if

      for sub_indices in sub_indices_list
        new_indices = vcat( [index], sub_indices )
        r_value = (sum∘filter)( x -> x > 0, new_indices ) 
        s_value = (abs∘sum∘filter)( x -> x < 0, new_indices ) 
        if r_value <= r_max && s_value <= s_max
          push!( indices_list, new_indices )
        end # if
      end # for sub_indices

    end # for index
    return indices_list

  end # if

end # function generate_lists


########################
function main()::Nothing
########################

  r_max = 16
  s_max = 0 # we assume vaccum integrals have no negative xpt. 

  indices_list = Vector{Vector{Int64}}()
  for indices in generate_lists( 3, r_max, s_max )
    if sum(indices) < 1
      continue
    end # if
    push!( indices_list, indices )
  end # for indices

  for typei in 0:6 
    file = open( "integrals_vac2loopT$(typei)", "w" )
    for indices in indices_list
      write( file, "vac2loopT$(typei)$(indices)\n" ) 
    end # for indices
    close( file )
  end # for typei

  return nothing

end # function main

###########
main()
###########


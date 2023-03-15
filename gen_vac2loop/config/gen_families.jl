using Combinatorics

##########################
function main()::Nothing
##########################

  index = 0::Int64
  result_str = """
  integralfamilies:
  """
  for pos_list in (reverse∘collect∘powerset)( [1,2,3], 1, 3 )
    result_str *= """
      - name: "vac2loopT$(index)"
        loop_momenta: [q1, q2]
        top_level_sectors: [b111]
        propagators:
          - [ "q1",    "$(1 in pos_list ? "nim" : "0" )" ]
          - [ "q2",    "$(2 in pos_list ? "nim" : "0" )" ]
          - [ "q1+q2", "$(3 in pos_list ? "nim" : "0" )" ]
    """
    index += 1::Int64
  end # for pos_list

  file = open( "integralfamilies.yaml", "w" )
  write( file, result_str )
  close( file )
  
  return nothing

end # function main

#######
main()
#######


flowchart TB
    subgraph External
        ST[Site to be tested]
    end

    subgraph Core System
        HS[Handler Service]
        RT[Router]
        CK[Cookie]
        MP[Main Page]
        RP[Result Page]
        LLM[LLM]
    end

    ST --> HS
    HS --> LLM
    HS --> RT
    CK --> MP
    RT --> MP
    RT --> RP

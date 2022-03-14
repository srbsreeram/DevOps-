if [[ "$MANUAL_COMMIT_ID" = '' || "$MANUAL_COMMIT_ID" = Null ]]; then	

    echo "manual commit id not provided"

    if [[ "$GIT_PREVIOUS_SUCCESSFUL_COMMIT" = '' || "$GIT_PREVIOUS_SUCCESSFUL_COMMIT" = Null ]]; then
        
        echo "no prev successful commit id"

        COMMIT_ID=$GIT_COMMIT

        echo $COMMIT_ID

    else

        echo "prev successful commit id"

        count=$(git log --pretty=oneline HEAD...$GIT_PREVIOUS_SUCCESSFUL_COMMIT --first-parent | wc -l )

        if [[ "$count" = 0 ]]; then
            
            echo "no deployment to occur"
            exit 0

        else
            
            COMMIT_ID=$GIT_PREVIOUS_SUCCESSFUL_COMMIT

        fi


    fi
          
    echo "$COMMIT_ID"
          
     
else

    echo "manual commit id provided"
        
    count=$(git log --pretty=oneline HEAD...$MANUAL_COMMIT_ID --first-parent | wc -l )
    
    if [[ "$count" = 0 ]]; then

            echo "manual commit id is latest commit id"

            if [[ "$MANUAL_COMMIT_ID" == "$GIT_PREVIOUS_SUCCESSFUL_COMMIT" ]]; then

                echo "no deployment to occur"
                exit 0
              
            elif [[ "$GIT_PREVIOUS_SUCCESSFUL_COMMIT" = '' || "$GIT_PREVIOUS_SUCCESSFUL_COMMIT" = Null ]]; then

                echo "No PREVIOUS_SUCCESSFUL_COMMIT_ID"

                COMMIT_ID=$MANUAL_COMMIT_ID
                echo $COMMIT_ID

                  
                  
            else
                
                echo "commit id same as prev successful commit id"

                COMMIT_ID=$GIT_PREVIOUS_SUCCESSFUL_COMMIT
                  
            fi
    else

        echo "manual commit id not latest"

        COMMIT_ID=$MANUAL_COMMIT_ID

    fi
fi

sh "${WORKSPACE}/scripts/manifest_jenkins.sh" $COMMIT_ID
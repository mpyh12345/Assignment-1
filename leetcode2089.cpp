class Solution {
public:
    vector<int> targetIndices(vector<int>& nums, int target) {
        
        int i=0,j=0,len=nums.size();
        bool flag=0;
        vector<int> out;
        
        for(i=0;i<len;i++)
        {
            for(j=0;j<len-1;j++)
                if(nums[j]>nums[j+1])
                    swap(nums[j],nums[j+1]);
        }
        i=0;
        while(len>0)
        {
            if(nums[i]==target)
            {
                out.push_back(i);
                flag=1;
            }
            else if(nums[i]!=target && flag==1)
                break;
            i++,len--;
            
        }
        
        
        return out;
        
    }
};
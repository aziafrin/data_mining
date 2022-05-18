{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "0e8bb1d6",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-05-18T15:32:09.745320Z",
     "iopub.status.busy": "2022-05-18T15:32:09.742841Z",
     "iopub.status.idle": "2022-05-18T15:32:10.980601Z",
     "shell.execute_reply": "2022-05-18T15:32:10.978793Z"
    },
    "papermill": {
     "duration": 1.246056,
     "end_time": "2022-05-18T15:32:10.982974",
     "exception": false,
     "start_time": "2022-05-18T15:32:09.736918",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.6     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.8\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.0     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'minimum-temperature-dataset'"
      ],
      "text/latex": [
       "'minimum-temperature-dataset'"
      ],
      "text/markdown": [
       "'minimum-temperature-dataset'"
      ],
      "text/plain": [
       "[1] \"minimum-temperature-dataset\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "eec26ef8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-18T15:32:11.021104Z",
     "iopub.status.busy": "2022-05-18T15:32:10.989804Z",
     "iopub.status.idle": "2022-05-18T15:32:11.085012Z",
     "shell.execute_reply": "2022-05-18T15:32:11.082829Z"
    },
    "papermill": {
     "duration": 0.101922,
     "end_time": "2022-05-18T15:32:11.087717",
     "exception": false,
     "start_time": "2022-05-18T15:32:10.985795",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Station</th><th scope=col>Jan</th><th scope=col>Feb</th><th scope=col>Mar</th><th scope=col>Apr</th><th scope=col>May</th><th scope=col>Jun</th><th scope=col>Jul</th><th scope=col>Aug</th><th scope=col>Sep</th><th scope=col>Oct</th><th scope=col>Nov</th><th scope=col>Dec</th><th scope=col>Peroid</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Barisal   </td><td>12.0</td><td>15.4</td><td>20.5</td><td>23.8</td><td>24.9</td><td>25.8</td><td>25.7</td><td>25.8</td><td>25.4</td><td>23.7</td><td>18.9</td><td>13.6</td><td>1981-2010</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Bhola     </td><td>12.6</td><td>16.0</td><td>21.0</td><td>24.1</td><td>25.2</td><td>26.1</td><td>25.9</td><td>26.1</td><td>25.7</td><td>24.0</td><td>19.4</td><td>14.4</td><td>1981-2010</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Bogra     </td><td>11.7</td><td>14.4</td><td>19.0</td><td>22.6</td><td>24.1</td><td>25.8</td><td>26.2</td><td>26.4</td><td>25.7</td><td>23.3</td><td>18.3</td><td>13.7</td><td>1981-2010</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Chandpur  </td><td>13.5</td><td>16.1</td><td>20.7</td><td>23.7</td><td>24.8</td><td>25.9</td><td>25.9</td><td>26.1</td><td>25.8</td><td>24.3</td><td>20.0</td><td>15.4</td><td>1981-2010</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Chittagong</td><td>14.0</td><td>16.3</td><td>20.5</td><td>23.6</td><td>24.9</td><td>25.4</td><td>25.2</td><td>25.3</td><td>25.2</td><td>24.1</td><td>20.3</td><td>15.8</td><td>1981-2010</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Chuadanga </td><td>10.7</td><td>14.3</td><td>19.1</td><td>23.7</td><td>25.1</td><td>26.1</td><td>26.2</td><td>26.3</td><td>25.7</td><td>23.4</td><td>18.0</td><td>12.6</td><td>1989-2010</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 14\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & Station & Jan & Feb & Mar & Apr & May & Jun & Jul & Aug & Sep & Oct & Nov & Dec & Peroid\\\\\n",
       "  & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & Barisal    & 12.0 & 15.4 & 20.5 & 23.8 & 24.9 & 25.8 & 25.7 & 25.8 & 25.4 & 23.7 & 18.9 & 13.6 & 1981-2010\\\\\n",
       "\t2 & Bhola      & 12.6 & 16.0 & 21.0 & 24.1 & 25.2 & 26.1 & 25.9 & 26.1 & 25.7 & 24.0 & 19.4 & 14.4 & 1981-2010\\\\\n",
       "\t3 & Bogra      & 11.7 & 14.4 & 19.0 & 22.6 & 24.1 & 25.8 & 26.2 & 26.4 & 25.7 & 23.3 & 18.3 & 13.7 & 1981-2010\\\\\n",
       "\t4 & Chandpur   & 13.5 & 16.1 & 20.7 & 23.7 & 24.8 & 25.9 & 25.9 & 26.1 & 25.8 & 24.3 & 20.0 & 15.4 & 1981-2010\\\\\n",
       "\t5 & Chittagong & 14.0 & 16.3 & 20.5 & 23.6 & 24.9 & 25.4 & 25.2 & 25.3 & 25.2 & 24.1 & 20.3 & 15.8 & 1981-2010\\\\\n",
       "\t6 & Chuadanga  & 10.7 & 14.3 & 19.1 & 23.7 & 25.1 & 26.1 & 26.2 & 26.3 & 25.7 & 23.4 & 18.0 & 12.6 & 1989-2010\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 14\n",
       "\n",
       "| <!--/--> | Station &lt;chr&gt; | Jan &lt;dbl&gt; | Feb &lt;dbl&gt; | Mar &lt;dbl&gt; | Apr &lt;dbl&gt; | May &lt;dbl&gt; | Jun &lt;dbl&gt; | Jul &lt;dbl&gt; | Aug &lt;dbl&gt; | Sep &lt;dbl&gt; | Oct &lt;dbl&gt; | Nov &lt;dbl&gt; | Dec &lt;dbl&gt; | Peroid &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | Barisal    | 12.0 | 15.4 | 20.5 | 23.8 | 24.9 | 25.8 | 25.7 | 25.8 | 25.4 | 23.7 | 18.9 | 13.6 | 1981-2010 |\n",
       "| 2 | Bhola      | 12.6 | 16.0 | 21.0 | 24.1 | 25.2 | 26.1 | 25.9 | 26.1 | 25.7 | 24.0 | 19.4 | 14.4 | 1981-2010 |\n",
       "| 3 | Bogra      | 11.7 | 14.4 | 19.0 | 22.6 | 24.1 | 25.8 | 26.2 | 26.4 | 25.7 | 23.3 | 18.3 | 13.7 | 1981-2010 |\n",
       "| 4 | Chandpur   | 13.5 | 16.1 | 20.7 | 23.7 | 24.8 | 25.9 | 25.9 | 26.1 | 25.8 | 24.3 | 20.0 | 15.4 | 1981-2010 |\n",
       "| 5 | Chittagong | 14.0 | 16.3 | 20.5 | 23.6 | 24.9 | 25.4 | 25.2 | 25.3 | 25.2 | 24.1 | 20.3 | 15.8 | 1981-2010 |\n",
       "| 6 | Chuadanga  | 10.7 | 14.3 | 19.1 | 23.7 | 25.1 | 26.1 | 26.2 | 26.3 | 25.7 | 23.4 | 18.0 | 12.6 | 1989-2010 |\n",
       "\n"
      ],
      "text/plain": [
       "  Station    Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec \n",
       "1 Barisal    12.0 15.4 20.5 23.8 24.9 25.8 25.7 25.8 25.4 23.7 18.9 13.6\n",
       "2 Bhola      12.6 16.0 21.0 24.1 25.2 26.1 25.9 26.1 25.7 24.0 19.4 14.4\n",
       "3 Bogra      11.7 14.4 19.0 22.6 24.1 25.8 26.2 26.4 25.7 23.3 18.3 13.7\n",
       "4 Chandpur   13.5 16.1 20.7 23.7 24.8 25.9 25.9 26.1 25.8 24.3 20.0 15.4\n",
       "5 Chittagong 14.0 16.3 20.5 23.6 24.9 25.4 25.2 25.3 25.2 24.1 20.3 15.8\n",
       "6 Chuadanga  10.7 14.3 19.1 23.7 25.1 26.1 26.2 26.3 25.7 23.4 18.0 12.6\n",
       "  Peroid   \n",
       "1 1981-2010\n",
       "2 1981-2010\n",
       "3 1981-2010\n",
       "4 1981-2010\n",
       "5 1981-2010\n",
       "6 1989-2010"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Jan</th><th scope=col>Feb</th><th scope=col>Mar</th><th scope=col>Apr</th><th scope=col>May</th><th scope=col>Jun</th><th scope=col>Jul</th><th scope=col>Aug</th><th scope=col>Sep</th><th scope=col>Oct</th><th scope=col>Nov</th><th scope=col>Dec</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>Barisal</th><td>12.0</td><td>15.4</td><td>20.5</td><td>23.8</td><td>24.9</td><td>25.8</td><td>25.7</td><td>25.8</td><td>25.4</td><td>23.7</td><td>18.9</td><td>13.6</td></tr>\n",
       "\t<tr><th scope=row>Bhola</th><td>12.6</td><td>16.0</td><td>21.0</td><td>24.1</td><td>25.2</td><td>26.1</td><td>25.9</td><td>26.1</td><td>25.7</td><td>24.0</td><td>19.4</td><td>14.4</td></tr>\n",
       "\t<tr><th scope=row>Bogra</th><td>11.7</td><td>14.4</td><td>19.0</td><td>22.6</td><td>24.1</td><td>25.8</td><td>26.2</td><td>26.4</td><td>25.7</td><td>23.3</td><td>18.3</td><td>13.7</td></tr>\n",
       "\t<tr><th scope=row>Chandpur</th><td>13.5</td><td>16.1</td><td>20.7</td><td>23.7</td><td>24.8</td><td>25.9</td><td>25.9</td><td>26.1</td><td>25.8</td><td>24.3</td><td>20.0</td><td>15.4</td></tr>\n",
       "\t<tr><th scope=row>Chittagong</th><td>14.0</td><td>16.3</td><td>20.5</td><td>23.6</td><td>24.9</td><td>25.4</td><td>25.2</td><td>25.3</td><td>25.2</td><td>24.1</td><td>20.3</td><td>15.8</td></tr>\n",
       "\t<tr><th scope=row>Chuadanga</th><td>10.7</td><td>14.3</td><td>19.1</td><td>23.7</td><td>25.1</td><td>26.1</td><td>26.2</td><td>26.3</td><td>25.7</td><td>23.4</td><td>18.0</td><td>12.6</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & Jan & Feb & Mar & Apr & May & Jun & Jul & Aug & Sep & Oct & Nov & Dec\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\tBarisal & 12.0 & 15.4 & 20.5 & 23.8 & 24.9 & 25.8 & 25.7 & 25.8 & 25.4 & 23.7 & 18.9 & 13.6\\\\\n",
       "\tBhola & 12.6 & 16.0 & 21.0 & 24.1 & 25.2 & 26.1 & 25.9 & 26.1 & 25.7 & 24.0 & 19.4 & 14.4\\\\\n",
       "\tBogra & 11.7 & 14.4 & 19.0 & 22.6 & 24.1 & 25.8 & 26.2 & 26.4 & 25.7 & 23.3 & 18.3 & 13.7\\\\\n",
       "\tChandpur & 13.5 & 16.1 & 20.7 & 23.7 & 24.8 & 25.9 & 25.9 & 26.1 & 25.8 & 24.3 & 20.0 & 15.4\\\\\n",
       "\tChittagong & 14.0 & 16.3 & 20.5 & 23.6 & 24.9 & 25.4 & 25.2 & 25.3 & 25.2 & 24.1 & 20.3 & 15.8\\\\\n",
       "\tChuadanga & 10.7 & 14.3 & 19.1 & 23.7 & 25.1 & 26.1 & 26.2 & 26.3 & 25.7 & 23.4 & 18.0 & 12.6\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | Jan &lt;dbl&gt; | Feb &lt;dbl&gt; | Mar &lt;dbl&gt; | Apr &lt;dbl&gt; | May &lt;dbl&gt; | Jun &lt;dbl&gt; | Jul &lt;dbl&gt; | Aug &lt;dbl&gt; | Sep &lt;dbl&gt; | Oct &lt;dbl&gt; | Nov &lt;dbl&gt; | Dec &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| Barisal | 12.0 | 15.4 | 20.5 | 23.8 | 24.9 | 25.8 | 25.7 | 25.8 | 25.4 | 23.7 | 18.9 | 13.6 |\n",
       "| Bhola | 12.6 | 16.0 | 21.0 | 24.1 | 25.2 | 26.1 | 25.9 | 26.1 | 25.7 | 24.0 | 19.4 | 14.4 |\n",
       "| Bogra | 11.7 | 14.4 | 19.0 | 22.6 | 24.1 | 25.8 | 26.2 | 26.4 | 25.7 | 23.3 | 18.3 | 13.7 |\n",
       "| Chandpur | 13.5 | 16.1 | 20.7 | 23.7 | 24.8 | 25.9 | 25.9 | 26.1 | 25.8 | 24.3 | 20.0 | 15.4 |\n",
       "| Chittagong | 14.0 | 16.3 | 20.5 | 23.6 | 24.9 | 25.4 | 25.2 | 25.3 | 25.2 | 24.1 | 20.3 | 15.8 |\n",
       "| Chuadanga | 10.7 | 14.3 | 19.1 | 23.7 | 25.1 | 26.1 | 26.2 | 26.3 | 25.7 | 23.4 | 18.0 | 12.6 |\n",
       "\n"
      ],
      "text/plain": [
       "           Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec \n",
       "Barisal    12.0 15.4 20.5 23.8 24.9 25.8 25.7 25.8 25.4 23.7 18.9 13.6\n",
       "Bhola      12.6 16.0 21.0 24.1 25.2 26.1 25.9 26.1 25.7 24.0 19.4 14.4\n",
       "Bogra      11.7 14.4 19.0 22.6 24.1 25.8 26.2 26.4 25.7 23.3 18.3 13.7\n",
       "Chandpur   13.5 16.1 20.7 23.7 24.8 25.9 25.9 26.1 25.8 24.3 20.0 15.4\n",
       "Chittagong 14.0 16.3 20.5 23.6 24.9 25.4 25.2 25.3 25.2 24.1 20.3 15.8\n",
       "Chuadanga  10.7 14.3 19.1 23.7 25.1 26.1 26.2 26.3 25.7 23.4 18.0 12.6"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "###Kmeans clustering algorithm for minimumtemperature data\n",
    "\n",
    "x1<-read.csv(\"../input/minimum-temperature-dataset/MIN TEM.csv\",header=T)\n",
    "head(x1)\n",
    "rownames(x1)<-x1[,1]\n",
    "x1[c(1,14)]=NULL\n",
    "head(x1)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "4c8c2241",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-18T15:32:11.096971Z",
     "iopub.status.busy": "2022-05-18T15:32:11.095443Z",
     "iopub.status.idle": "2022-05-18T15:32:11.159819Z",
     "shell.execute_reply": "2022-05-18T15:32:11.157657Z"
    },
    "papermill": {
     "duration": 0.071624,
     "end_time": "2022-05-18T15:32:11.162597",
     "exception": false,
     "start_time": "2022-05-18T15:32:11.090973",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.29"
      ],
      "text/latex": [
       "0.29"
      ],
      "text/markdown": [
       "0.29"
      ],
      "text/plain": [
       "[1] 0.29"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "set.seed(170105)\n",
    "ID=sample(nrow(x1),round(nrow(x1)*.8,0),F)\n",
    "x=x1[ID,]\n",
    "wss=(nrow(x)-1)*sum(apply(x,2,var))\n",
    "for (i in 2:25)\n",
    "wss[i]=sum(kmeans(x,center=i,iter.max=10000,nstart=13,algorithm=c(\"MacQueen\"))$withinss)\n",
    "id=which(min(wss)==wss)\n",
    "\n",
    "m_wss=wss[id]\n",
    "m_wss\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "6cf089d5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-18T15:32:11.172038Z",
     "iopub.status.busy": "2022-05-18T15:32:11.170501Z",
     "iopub.status.idle": "2022-05-18T15:32:11.434322Z",
     "shell.execute_reply": "2022-05-18T15:32:11.432402Z"
    },
    "papermill": {
     "duration": 0.270714,
     "end_time": "2022-05-18T15:32:11.436606",
     "exception": false,
     "start_time": "2022-05-18T15:32:11.165892",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nsWNv376dMWPGlClTvtiDvLy8sbGxsbExEZ05c+bChQsHDhxQUFBglqakpMTFxcXGxt6+ffvU\nqVO5ubkbNmxgFklKShoaGnbr1q1Dhw6mpqY9evTQ1NSs1PnTp09Hjx4tIyMTEBAwZswY5kLs\n06dPZ8+evWXLlpYtW/74448NuTsAAMQagh2AmNPS0vr7779dXV2PHj0aHh7ONOro6OzevXvu\n3Ll1vR5mZ2cXGBi4a9euVatWMS3MYAsbG5v8/PyTJ0/u3bu3T58+TNS7f/9+XFzcsWPH+Hw+\ns7KKioqpqakg6nXr1m3t2rVFRUVXrlzp3bu34FNMTExCQkK6d+++fv362bNnKyoqNsSeAAAQ\nfwh2AOJPVVV1//79Hh4eDx8+zM/P19bWNjU1rd9NipMnT96+ffvPP/8sJyc3f/58ZghFaWnp\nnj171q5d26FDh6lTp0pKSnbo0MHBwYF5S1ZWVkxMjCDqPXr0KDIyklnE5XLLy8vV1NQuXbqU\nnJxsampqamrKZE1ZWdmlS5fOmjWLeWZaA+0JAAAxh2AHIgPz2H0lWVnZrx+vKikpGRwcPHTo\nUGdn519//bVHjx5E9Pfff6elpbVr1y44OFhSUrLSW5SVlS0tLS0tLZkfeTxeYmJidHT0kydP\n7ty5ExISkp6ezsy3x6w8cODAESNGjBgxonPnzkRUcV5lAACoGYIdiAzMY9dE6OvrP3jwYNeu\nXf7+/mFhYURkYmLi4uKycOFCeXn5L76dzWa3a9euXbt248aNe/v2ra6u7sKFCydNmvT48ePH\njx8/fPgwKCjozJkzbDbbxMSEiNLS0r75JtVCbm5uaGio4BFqtra2grsMAQCaDgQ7EBmYx67p\nkJeXd3V1dXV1/cp+NDU1lZSU7t27t3Pnzl69ejGNmZmZYWFhwcHBf/75JxFt37792LFjgwcP\ntre3HzZsWG2yY4Pz8vJas2ZNVlaWoEVZWXnTpk140gYANDX46wgig5nHztra2sbGhsfjCbsc\naABcLnfcuHFRUVFnz54VNKqoqDg4OGzbtk1VVVVFRWXZsmVBquG3AAAgAElEQVQtWrTw9fUd\nP368urq6ra0t8zDcmnu+devW9OnTjY2NdXV1e/TosWbNmvfv39evyA0bNixcuFBVVdXLy+v+\n/fv379/38vJSVVVdsGDBxo0b69cnAMC3wocvmT59OhFt3LhR2IU0d/Hx8YLf2/j4eGGXAw3j\n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\no9qSeEg8AMBXaWp/8wYMGNCqVavt27dPnDiRGXkq4Ovre//+/QULFjBfSauoqNTmOlZGRsbJ\nkycPHDggGEkgkJaWpq2tPWHChGPHjtWyvJKSElVV1W7dul25cqXq0j179syfP//06dPMnCzM\n/DLMImYaGiIqKioqLCxkGjMzM8+fP+/p6blu3Tom0TIz1DDTBGZnZwcFBcXGxo4ePbq8vJxp\nKSwszMzMfPnyJZNlP1ennZ3d5xZduXKlrtOyXL58+fLly59bOnv2bBcXF1lZWUVFRUVFRVlZ\nWTk5OWVlZTk5OVlZWQUFBSUlJaZRSUnp3r17JSUldnZ2r1+/ZhoFv4EmJiZDhgy5dOlSUVFR\nxQHCNTt06FBaWtqRI0cqzZVoY2Ozc+fOGTNmHDp0aMmSJXXa3qZPlIJd1LKhvo8/WS70POE+\nX0eumsp5JZ9ObF4wxe247SKn2H3WjV4gfFuYxw6gmZOUlNy1a9fYsWP79u3722+/jRw5UlFR\n8eXLl/v27du+fXvr1q3d3Nzq1OG4ceP8/PzWr1+/e/fuSovWrVvH4/EqfWX5xfJGjhx58uTJ\n69evW1tbV1yUk5Pz+++/KykpCRKGpKSk4Ovyz2VQDQ0NT0/Pd+/eVd2ugoICb29vExOTM2fO\nfK4ewdVKwYvFixenpKRs2bJF0FJx/T/++KNFixbMLW7MhbfP9czMX52fn7906VILC4upU6cK\nFpWXl+fk5OTm5sbFxQUGBnbt2lVLSys/Pz83NzcnJ+fDhw9MPZ/rmYjWrl27du1awY/MF9lc\nLre0tLS0tLRHjx5SUlLMHlNSUmKz2cwM2/Ly8hISEszk28zX3JKSkr6+vlJSUurq6teuXVNU\nVGSxWO3bt2dutps4ceKCBQvCwsLEL9iJ0uCJfkpS8lpzv7ja3t6aUooWteyzrKwsKCjIv0bM\n+bl+/fqvKx++FkbFAgCfzz9x4oQgcwi+sDM3N3/+/Hldu+LxeIMGDSKiOXPmCIZwpqSkzJkz\nh4gGDRpU1/lEEhISFBUVlZSUDh8+LJiT5c6dO8xdd9XOI1OzAQMGcDicU6dOVWwsLi6ePHky\nEe3evbtOvS1evJiIHj58WHXRgwcPiGjx4sV16tDExITJbVUXOTk5EVHVmW4YeXl5aWlpiYmJ\nDx48CA8PDwkJ8ff3Z+bomTdvnqur66JFixwdHR0cHEaNGmVjY2Ntbc3c4qmnp6evr89cka3T\nnN6MgQMHCmowNDTs2rVrnbZXoCkPnhClYKfMZWv2uvDF1f5eYcbmKteyz9DQ0Fr+NlQ7Hh4a\nGeaxAwA+n5+Zmenl5TV16tQxY8YsWrQoKCio3v/Yy8zMZK6isdlsfX19fX19Ji7Y2NhUO0Py\nF928eZOZjU9OTq5Dhw5MHOFwOPWbWiEpKUlLS4vFYo0cOfLQoUNnzpzZsmWLsbExEY0ZM6au\nA58fPnzIZrP79u1bKYrl5+f36dOHzWZXm/lqwFzpnDx5cqWZBU+dOsXhcAYMGFCn3sLCwojo\nl19+qbqIx+OZmZm1bNmy6oHOycnJyMhITk5OTEx88uTJvXv3IiIiQkNDL1y4YGpqqqCgsG/f\nvj179ri7u7u7u4eFhQneqKamZmVlVacKBRDsGsY0DTkppX7vi2s8e8sL5rVRlG05oZZ91uaK\n3bRp04jo2rVrX78J8DVwxQ4AvoXy8vJz585NmjTJ3Nzc3Nx80qRJ586d+5r/yWRlZW3bts3W\n1tbU1LRPnz4uLi6xsbH17u3t27djx46teHVKWVn5l19+qd8/cVevXk1EJiYm3t7ez549e/bs\nmbe3N5MUf/rpp7r2VlZWNnr0aKbDLVu2nDlz5tChQyNHjmSxWNra2i9fvqxTbyUlJcxsfwkJ\nCZUW7d27l4iWLFlSpw6XLVtGRLdv3666KCoqioiWLVtWpw4FEOwaxvMjY4iohflY30v38sqq\nXB7nFcXePOM4UI+Ihu+Ka8DP9fDwIKKIiIgG7BPqAfPYAUCzlZqaGhQUdOLEiRs3bhQWFta7\nHx6Pt3XrVsGkbgx5efmtW7fW7zkWpaWlv/zyi7Ly/6cbY7PZY8eOffv2bT16u3jxIpfLbdmy\n5e7du5OTkwsLC6OjoxcsWMBmsw0NDev6ALTY2Fgul2tubl7p4mtmZqa5uTmXy6134G7KwY7F\n5/Nr+9W08PEOLhw8Z/dVHp/PkVTSb2eg3VJZSkqivKQ4O/190ovEjKIyFotlPW9XqNd8zpd7\nqy1PT08XF5eIiAgLC4uG6xXqLDY2lpkhnYhiYmKYqUoBAKCuMjMzL1y48OzZMxaLZWRkNGLE\niNpPhletoqKiO3fuvH//Xl5evkePHlVHGddecHCwo6Pjx48fKzZaWlr6+fm1bt26rr25u7uv\nWrWqdevWLi4uzKx1UVFRO3bsSE5Odnd3X7lyZf2KjIyMtLS09PDwcHZ2rl8P344ojYolYjvt\n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\nTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "plot(1:25,wss,type=\"o\",xlab=\"Number of clusters\",\n",
    "cex.axis=1,cex.lab=1,cex.main=1,\n",
    "col.axis=1,col.lab=1,col.main=1,\n",
    "font.axis=1,font.lab=1,font.main=1)\n",
    "abline(v=5,lty=2,lwd=2)\n",
    "abline(h=50, lty=2, lwd=2)\n",
    "points(5,50,pch=21,cex=2,col=\"red\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "960aa5e8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-18T15:32:11.448302Z",
     "iopub.status.busy": "2022-05-18T15:32:11.446667Z",
     "iopub.status.idle": "2022-05-18T15:32:11.487415Z",
     "shell.execute_reply": "2022-05-18T15:32:11.485503Z"
    },
    "papermill": {
     "duration": 0.049043,
     "end_time": "2022-05-18T15:32:11.490089",
     "exception": false,
     "start_time": "2022-05-18T15:32:11.441046",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "K-means clustering with 5 clusters of sizes 5, 7, 5, 5, 5\n",
      "\n",
      "Cluster means:\n",
      "       Jan      Feb      Mar   Apr      May      Jun      Jul      Aug      Sep\n",
      "1 12.00000 14.82000 19.02000 22.30 23.72000 25.40000 25.82000 25.98000 25.36000\n",
      "2 14.45714 17.17143 21.35714 24.40 25.45714 25.85714 25.58571 25.64286 25.47143\n",
      "3 13.30000 16.26000 20.82000 23.88 25.02000 26.04000 25.96000 26.10000 25.78000\n",
      "4 10.52000 13.16000 17.68000 21.90 23.68000 25.38000 25.86000 26.04000 25.30000\n",
      "5 12.20000 15.52000 20.38000 23.86 25.00000 25.86000 25.76000 25.80000 25.46000\n",
      "       Oct      Nov      Dec\n",
      "1 23.30000 18.44000 13.72000\n",
      "2 24.41429 20.61429 16.18571\n",
      "3 24.20000 19.88000 15.12000\n",
      "4 22.66000 17.30000 12.58000\n",
      "5 23.68000 18.92000 13.82000\n",
      "\n",
      "Clustering vector:\n",
      "     Teknaf    Kutubdia       Bogra       Dhaka   Sitakunda      Khulna \n",
      "          2           2           1           3           5           5 \n",
      "    Comilla    Satkhira        Feni   Madaripur    Sayedpur     Tangail \n",
      "          1           5           5           3           4           1 \n",
      "  Khepupara    Chandpur  Mymensingh     Barisal       Bhola Cox's Bazar \n",
      "          2           3           1           5           3           2 \n",
      "     Hatiya      Sylhet    Rajshahi      Mongla  Patuakhali     Rangpur \n",
      "          2           1           4           2           3           4 \n",
      "   Ishwardi     Sandwip   Srimangal \n",
      "          4           2           4 \n",
      "\n",
      "Within cluster sum of squares by cluster:\n",
      "[1] 10.55200 12.98857  4.88400 11.34800  7.22800\n",
      " (between_SS / total_SS =  86.1 %)\n",
      "\n",
      "Available components:\n",
      "\n",
      "[1] \"cluster\"      \"centers\"      \"totss\"        \"withinss\"     \"tot.withinss\"\n",
      "[6] \"betweenss\"    \"size\"         \"iter\"         \"ifault\"      \n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 5 × 12 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Jan</th><th scope=col>Feb</th><th scope=col>Mar</th><th scope=col>Apr</th><th scope=col>May</th><th scope=col>Jun</th><th scope=col>Jul</th><th scope=col>Aug</th><th scope=col>Sep</th><th scope=col>Oct</th><th scope=col>Nov</th><th scope=col>Dec</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>12.00000</td><td>14.82000</td><td>19.02000</td><td>22.30</td><td>23.72000</td><td>25.40000</td><td>25.82000</td><td>25.98000</td><td>25.36000</td><td>23.30000</td><td>18.44000</td><td>13.72000</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>14.45714</td><td>17.17143</td><td>21.35714</td><td>24.40</td><td>25.45714</td><td>25.85714</td><td>25.58571</td><td>25.64286</td><td>25.47143</td><td>24.41429</td><td>20.61429</td><td>16.18571</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>13.30000</td><td>16.26000</td><td>20.82000</td><td>23.88</td><td>25.02000</td><td>26.04000</td><td>25.96000</td><td>26.10000</td><td>25.78000</td><td>24.20000</td><td>19.88000</td><td>15.12000</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>10.52000</td><td>13.16000</td><td>17.68000</td><td>21.90</td><td>23.68000</td><td>25.38000</td><td>25.86000</td><td>26.04000</td><td>25.30000</td><td>22.66000</td><td>17.30000</td><td>12.58000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>12.20000</td><td>15.52000</td><td>20.38000</td><td>23.86</td><td>25.00000</td><td>25.86000</td><td>25.76000</td><td>25.80000</td><td>25.46000</td><td>23.68000</td><td>18.92000</td><td>13.82000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 5 × 12 of type dbl\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & Jan & Feb & Mar & Apr & May & Jun & Jul & Aug & Sep & Oct & Nov & Dec\\\\\n",
       "\\hline\n",
       "\t1 & 12.00000 & 14.82000 & 19.02000 & 22.30 & 23.72000 & 25.40000 & 25.82000 & 25.98000 & 25.36000 & 23.30000 & 18.44000 & 13.72000\\\\\n",
       "\t2 & 14.45714 & 17.17143 & 21.35714 & 24.40 & 25.45714 & 25.85714 & 25.58571 & 25.64286 & 25.47143 & 24.41429 & 20.61429 & 16.18571\\\\\n",
       "\t3 & 13.30000 & 16.26000 & 20.82000 & 23.88 & 25.02000 & 26.04000 & 25.96000 & 26.10000 & 25.78000 & 24.20000 & 19.88000 & 15.12000\\\\\n",
       "\t4 & 10.52000 & 13.16000 & 17.68000 & 21.90 & 23.68000 & 25.38000 & 25.86000 & 26.04000 & 25.30000 & 22.66000 & 17.30000 & 12.58000\\\\\n",
       "\t5 & 12.20000 & 15.52000 & 20.38000 & 23.86 & 25.00000 & 25.86000 & 25.76000 & 25.80000 & 25.46000 & 23.68000 & 18.92000 & 13.82000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 5 × 12 of type dbl\n",
       "\n",
       "| <!--/--> | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 12.00000 | 14.82000 | 19.02000 | 22.30 | 23.72000 | 25.40000 | 25.82000 | 25.98000 | 25.36000 | 23.30000 | 18.44000 | 13.72000 |\n",
       "| 2 | 14.45714 | 17.17143 | 21.35714 | 24.40 | 25.45714 | 25.85714 | 25.58571 | 25.64286 | 25.47143 | 24.41429 | 20.61429 | 16.18571 |\n",
       "| 3 | 13.30000 | 16.26000 | 20.82000 | 23.88 | 25.02000 | 26.04000 | 25.96000 | 26.10000 | 25.78000 | 24.20000 | 19.88000 | 15.12000 |\n",
       "| 4 | 10.52000 | 13.16000 | 17.68000 | 21.90 | 23.68000 | 25.38000 | 25.86000 | 26.04000 | 25.30000 | 22.66000 | 17.30000 | 12.58000 |\n",
       "| 5 | 12.20000 | 15.52000 | 20.38000 | 23.86 | 25.00000 | 25.86000 | 25.76000 | 25.80000 | 25.46000 | 23.68000 | 18.92000 | 13.82000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Jan      Feb      Mar      Apr   May      Jun      Jul      Aug      Sep     \n",
       "1 12.00000 14.82000 19.02000 22.30 23.72000 25.40000 25.82000 25.98000 25.36000\n",
       "2 14.45714 17.17143 21.35714 24.40 25.45714 25.85714 25.58571 25.64286 25.47143\n",
       "3 13.30000 16.26000 20.82000 23.88 25.02000 26.04000 25.96000 26.10000 25.78000\n",
       "4 10.52000 13.16000 17.68000 21.90 23.68000 25.38000 25.86000 26.04000 25.30000\n",
       "5 12.20000 15.52000 20.38000 23.86 25.00000 25.86000 25.76000 25.80000 25.46000\n",
       "  Oct      Nov      Dec     \n",
       "1 23.30000 18.44000 13.72000\n",
       "2 24.41429 20.61429 16.18571\n",
       "3 24.20000 19.88000 15.12000\n",
       "4 22.66000 17.30000 12.58000\n",
       "5 23.68000 18.92000 13.82000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "NULL"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "k=kmeans(x,center=5,iter.max=10000,nstart=13,algorithm=c(\"MacQueen\"))\n",
    "print(k)\n",
    "k$center\n",
    "k$clusters\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "6a58ad02",
   "metadata": {
    "papermill": {
     "duration": 0.004852,
     "end_time": "2022-05-18T15:32:11.499834",
     "exception": false,
     "start_time": "2022-05-18T15:32:11.494982",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 5.19179,
   "end_time": "2022-05-18T15:32:11.625475",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-05-18T15:32:06.433685",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}

{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "accaaa0f",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:23.666275Z",
     "iopub.status.busy": "2022-05-07T07:40:23.664207Z",
     "iopub.status.idle": "2022-05-07T07:40:25.035328Z",
     "shell.execute_reply": "2022-05-07T07:40:25.033522Z"
    },
    "papermill": {
     "duration": 1.380636,
     "end_time": "2022-05-07T07:40:25.037902",
     "exception": false,
     "start_time": "2022-05-07T07:40:23.657266",
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
       "'mymensingh'"
      ],
      "text/latex": [
       "'mymensingh'"
      ],
      "text/markdown": [
       "'mymensingh'"
      ],
      "text/plain": [
       "[1] \"mymensingh\""
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
   "id": "3ed38f9a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.082447Z",
     "iopub.status.busy": "2022-05-07T07:40:25.049478Z",
     "iopub.status.idle": "2022-05-07T07:40:25.120977Z",
     "shell.execute_reply": "2022-05-07T07:40:25.119184Z"
    },
    "papermill": {
     "duration": 0.080441,
     "end_time": "2022-05-07T07:40:25.123481",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.043040",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "###K nearest neighbor(knn) clustering algorithm for mymensingh data\n",
    "##required package\n",
    "library(class)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "69eec4b9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.135700Z",
     "iopub.status.busy": "2022-05-07T07:40:25.134206Z",
     "iopub.status.idle": "2022-05-07T07:40:25.181873Z",
     "shell.execute_reply": "2022-05-07T07:40:25.180092Z"
    },
    "papermill": {
     "duration": 0.056181,
     "end_time": "2022-05-07T07:40:25.184245",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.128064",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ID</th><th scope=col>Station</th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>T_RAN</th><th scope=col>A_RAIN</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>Mymensingh</td><td>1960</td><td>1</td><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td> 15</td><td> 0.48</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>Mymensingh</td><td>1960</td><td>2</td><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>  0</td><td> 0.00</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>Mymensingh</td><td>1960</td><td>3</td><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td> 69</td><td> 2.23</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>Mymensingh</td><td>1960</td><td>4</td><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td> 27</td><td> 0.90</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>Mymensingh</td><td>1960</td><td>5</td><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>187</td><td> 6.03</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>Mymensingh</td><td>1960</td><td>6</td><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>363</td><td>12.10</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & ID & Station & Year & Month & TEM & DPT & WIS & HUM & SLP & T\\_RAN & A\\_RAIN & RAN\\\\\n",
       "  & <int> & <chr> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & Mymensingh & 1960 & 1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 &  15 &  0.48 & NRT\\\\\n",
       "\t2 & 2 & Mymensingh & 1960 & 2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 &   0 &  0.00 & NRT\\\\\n",
       "\t3 & 3 & Mymensingh & 1960 & 3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 &  69 &  2.23 & LTR\\\\\n",
       "\t4 & 4 & Mymensingh & 1960 & 4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 &  27 &  0.90 & NRT\\\\\n",
       "\t5 & 5 & Mymensingh & 1960 & 5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & 187 &  6.03 & LTR\\\\\n",
       "\t6 & 6 & Mymensingh & 1960 & 6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & 363 & 12.10 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | ID &lt;int&gt; | Station &lt;chr&gt; | Year &lt;int&gt; | Month &lt;int&gt; | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | T_RAN &lt;int&gt; | A_RAIN &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | Mymensingh | 1960 | 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 |  15 |  0.48 | NRT |\n",
       "| 2 | 2 | Mymensingh | 1960 | 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 |   0 |  0.00 | NRT |\n",
       "| 3 | 3 | Mymensingh | 1960 | 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 |  69 |  2.23 | LTR |\n",
       "| 4 | 4 | Mymensingh | 1960 | 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 |  27 |  0.90 | NRT |\n",
       "| 5 | 5 | Mymensingh | 1960 | 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | 187 |  6.03 | LTR |\n",
       "| 6 | 6 | Mymensingh | 1960 | 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | 363 | 12.10 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  ID Station    Year Month TEM  DPT  WIS HUM   SLP    T_RAN A_RAIN RAN\n",
       "1 1  Mymensingh 1960 1     16.9 11.3 2.0 73.39 1016.0  15    0.48  NRT\n",
       "2 2  Mymensingh 1960 2     21.4 12.6 1.7 66.34 1013.0   0    0.00  NRT\n",
       "3 3  Mymensingh 1960 3     24.1 14.9 2.3 64.13 1011.4  69    2.23  LTR\n",
       "4 4  Mymensingh 1960 4     29.9 17.6 2.2 59.03 1007.1  27    0.90  NRT\n",
       "5 5  Mymensingh 1960 5     29.6 23.2 2.4 73.45 1003.4 187    6.03  LTR\n",
       "6 6  Mymensingh 1960 6     28.2 24.1 2.0 84.03 1001.6 363   12.10  MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#load the dataset\n",
    "x1<-read.csv(\"../input/mymensingh/Mymensingh.csv\",header=T)\n",
    "head(x1)  #to see the first 6 row of the data\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "716c59bb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.197190Z",
     "iopub.status.busy": "2022-05-07T07:40:25.195580Z",
     "iopub.status.idle": "2022-05-07T07:40:25.229747Z",
     "shell.execute_reply": "2022-05-07T07:40:25.228069Z"
    },
    "papermill": {
     "duration": 0.042845,
     "end_time": "2022-05-07T07:40:25.232041",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.189196",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>672</li><li>12</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 672\n",
       "\\item 12\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 672\n",
       "2. 12\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 672  12"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "69"
      ],
      "text/latex": [
       "69"
      ],
      "text/markdown": [
       "69"
      ],
      "text/plain": [
       "[1] 69"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>654</li><li>12</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 654\n",
       "\\item 12\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 654\n",
       "2. 12\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 654  12"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(x1)             ##check the dimension of the data\n",
    "sum(is.na(x1))      ##check the pressence of missing value\n",
    "xx<-na.omit(x1)     ##omit the missing values if there any\n",
    "dim(xx)             #check the dimension again after dropping the missing values\n",
    "sum(is.na(xx))      #final check of missing values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "80a1e0f8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.246105Z",
     "iopub.status.busy": "2022-05-07T07:40:25.244561Z",
     "iopub.status.idle": "2022-05-07T07:40:25.271571Z",
     "shell.execute_reply": "2022-05-07T07:40:25.269882Z"
    },
    "papermill": {
     "duration": 0.050098,
     "end_time": "2022-05-07T07:40:25.287684",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.237586",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>TEM</th><th scope=col>DPT</th><th scope=col>WIS</th><th scope=col>HUM</th><th scope=col>SLP</th><th scope=col>RAN</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>16.9</td><td>11.3</td><td>2.0</td><td>73.39</td><td>1016.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>21.4</td><td>12.6</td><td>1.7</td><td>66.34</td><td>1013.0</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>24.1</td><td>14.9</td><td>2.3</td><td>64.13</td><td>1011.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>29.9</td><td>17.6</td><td>2.2</td><td>59.03</td><td>1007.1</td><td>NRT</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>29.6</td><td>23.2</td><td>2.4</td><td>73.45</td><td>1003.4</td><td>LTR</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>28.2</td><td>24.1</td><td>2.0</td><td>84.03</td><td>1001.6</td><td>MHR</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & TEM & DPT & WIS & HUM & SLP & RAN\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 16.9 & 11.3 & 2.0 & 73.39 & 1016.0 & NRT\\\\\n",
       "\t2 & 21.4 & 12.6 & 1.7 & 66.34 & 1013.0 & NRT\\\\\n",
       "\t3 & 24.1 & 14.9 & 2.3 & 64.13 & 1011.4 & LTR\\\\\n",
       "\t4 & 29.9 & 17.6 & 2.2 & 59.03 & 1007.1 & NRT\\\\\n",
       "\t5 & 29.6 & 23.2 & 2.4 & 73.45 & 1003.4 & LTR\\\\\n",
       "\t6 & 28.2 & 24.1 & 2.0 & 84.03 & 1001.6 & MHR\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | TEM &lt;dbl&gt; | DPT &lt;dbl&gt; | WIS &lt;dbl&gt; | HUM &lt;dbl&gt; | SLP &lt;dbl&gt; | RAN &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 16.9 | 11.3 | 2.0 | 73.39 | 1016.0 | NRT |\n",
       "| 2 | 21.4 | 12.6 | 1.7 | 66.34 | 1013.0 | NRT |\n",
       "| 3 | 24.1 | 14.9 | 2.3 | 64.13 | 1011.4 | LTR |\n",
       "| 4 | 29.9 | 17.6 | 2.2 | 59.03 | 1007.1 | NRT |\n",
       "| 5 | 29.6 | 23.2 | 2.4 | 73.45 | 1003.4 | LTR |\n",
       "| 6 | 28.2 | 24.1 | 2.0 | 84.03 | 1001.6 | MHR |\n",
       "\n"
      ],
      "text/plain": [
       "  TEM  DPT  WIS HUM   SLP    RAN\n",
       "1 16.9 11.3 2.0 73.39 1016.0 NRT\n",
       "2 21.4 12.6 1.7 66.34 1013.0 NRT\n",
       "3 24.1 14.9 2.3 64.13 1011.4 LTR\n",
       "4 29.9 17.6 2.2 59.03 1007.1 NRT\n",
       "5 29.6 23.2 2.4 73.45 1003.4 LTR\n",
       "6 28.2 24.1 2.0 84.03 1001.6 MHR"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "xx[,c(1:4,10,11)]=NULL      ##selecting the required column from the data\n",
    "head(xx)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "45b3676f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.302587Z",
     "iopub.status.busy": "2022-05-07T07:40:25.301036Z",
     "iopub.status.idle": "2022-05-07T07:40:25.322306Z",
     "shell.execute_reply": "2022-05-07T07:40:25.320533Z"
    },
    "papermill": {
     "duration": 0.031572,
     "end_time": "2022-05-07T07:40:25.324904",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.293332",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "##splitting the data into train dataset and test dataset\n",
    "set.seed(170105)\n",
    "ID=sample(1:nrow(xx),round(nrow(xx)*0.75,0),F)    \n",
    "TR<-xx[ID,]      ##training data\n",
    "TS<-xx[-ID,]      ##test dat\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "b5824c14",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.341237Z",
     "iopub.status.busy": "2022-05-07T07:40:25.339716Z",
     "iopub.status.idle": "2022-05-07T07:40:25.412230Z",
     "shell.execute_reply": "2022-05-07T07:40:25.410408Z"
    },
    "papermill": {
     "duration": 0.083952,
     "end_time": "2022-05-07T07:40:25.414702",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.330750",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "E=numeric(0)\n",
    "A=numeric(0)\n",
    "I=numeric(0)\n",
    "for(i in 2:20){\n",
    "KK<-knn(train=TR[,-6],test=TS[,-6],cl=TR[,6],k=i)\n",
    "    T<-table(TS[,6],KK)\n",
    "I[i-1]=i\n",
    "A[i-1]=sum(diag(T))/sum(T)   ##accuracy rate\n",
    "E[i-1]=1-sum(diag(T))/sum(T)  ##error rate\n",
    " }"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "4dd2a084",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.429754Z",
     "iopub.status.busy": "2022-05-07T07:40:25.428178Z",
     "iopub.status.idle": "2022-05-07T07:40:25.473389Z",
     "shell.execute_reply": "2022-05-07T07:40:25.471685Z"
    },
    "papermill": {
     "duration": 0.055342,
     "end_time": "2022-05-07T07:40:25.475844",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.420502",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>0.646341463414634</li><li>0.713414634146341</li><li>0.725609756097561</li><li>0.74390243902439</li><li>0.731707317073171</li><li>0.74390243902439</li><li>0.74390243902439</li><li>0.75</li><li>0.75</li><li>0.75</li><li>0.73780487804878</li><li>0.74390243902439</li><li>0.725609756097561</li><li>0.725609756097561</li><li>0.73780487804878</li><li>0.73780487804878</li><li>0.731707317073171</li><li>0.731707317073171</li><li>0.74390243902439</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 0.646341463414634\n",
       "\\item 0.713414634146341\n",
       "\\item 0.725609756097561\n",
       "\\item 0.74390243902439\n",
       "\\item 0.731707317073171\n",
       "\\item 0.74390243902439\n",
       "\\item 0.74390243902439\n",
       "\\item 0.75\n",
       "\\item 0.75\n",
       "\\item 0.75\n",
       "\\item 0.73780487804878\n",
       "\\item 0.74390243902439\n",
       "\\item 0.725609756097561\n",
       "\\item 0.725609756097561\n",
       "\\item 0.73780487804878\n",
       "\\item 0.73780487804878\n",
       "\\item 0.731707317073171\n",
       "\\item 0.731707317073171\n",
       "\\item 0.74390243902439\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 0.646341463414634\n",
       "2. 0.713414634146341\n",
       "3. 0.725609756097561\n",
       "4. 0.74390243902439\n",
       "5. 0.731707317073171\n",
       "6. 0.74390243902439\n",
       "7. 0.74390243902439\n",
       "8. 0.75\n",
       "9. 0.75\n",
       "10. 0.75\n",
       "11. 0.73780487804878\n",
       "12. 0.74390243902439\n",
       "13. 0.725609756097561\n",
       "14. 0.725609756097561\n",
       "15. 0.73780487804878\n",
       "16. 0.73780487804878\n",
       "17. 0.731707317073171\n",
       "18. 0.731707317073171\n",
       "19. 0.74390243902439\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 0.6463415 0.7134146 0.7256098 0.7439024 0.7317073 0.7439024 0.7439024\n",
       " [8] 0.7500000 0.7500000 0.7500000 0.7378049 0.7439024 0.7256098 0.7256098\n",
       "[15] 0.7378049 0.7378049 0.7317073 0.7317073 0.7439024"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>0.353658536585366</li><li>0.286585365853659</li><li>0.274390243902439</li><li>0.25609756097561</li><li>0.268292682926829</li><li>0.25609756097561</li><li>0.25609756097561</li><li>0.25</li><li>0.25</li><li>0.25</li><li>0.26219512195122</li><li>0.25609756097561</li><li>0.274390243902439</li><li>0.274390243902439</li><li>0.26219512195122</li><li>0.26219512195122</li><li>0.268292682926829</li><li>0.268292682926829</li><li>0.25609756097561</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 0.353658536585366\n",
       "\\item 0.286585365853659\n",
       "\\item 0.274390243902439\n",
       "\\item 0.25609756097561\n",
       "\\item 0.268292682926829\n",
       "\\item 0.25609756097561\n",
       "\\item 0.25609756097561\n",
       "\\item 0.25\n",
       "\\item 0.25\n",
       "\\item 0.25\n",
       "\\item 0.26219512195122\n",
       "\\item 0.25609756097561\n",
       "\\item 0.274390243902439\n",
       "\\item 0.274390243902439\n",
       "\\item 0.26219512195122\n",
       "\\item 0.26219512195122\n",
       "\\item 0.268292682926829\n",
       "\\item 0.268292682926829\n",
       "\\item 0.25609756097561\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 0.353658536585366\n",
       "2. 0.286585365853659\n",
       "3. 0.274390243902439\n",
       "4. 0.25609756097561\n",
       "5. 0.268292682926829\n",
       "6. 0.25609756097561\n",
       "7. 0.25609756097561\n",
       "8. 0.25\n",
       "9. 0.25\n",
       "10. 0.25\n",
       "11. 0.26219512195122\n",
       "12. 0.25609756097561\n",
       "13. 0.274390243902439\n",
       "14. 0.274390243902439\n",
       "15. 0.26219512195122\n",
       "16. 0.26219512195122\n",
       "17. 0.268292682926829\n",
       "18. 0.268292682926829\n",
       "19. 0.25609756097561\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 0.3536585 0.2865854 0.2743902 0.2560976 0.2682927 0.2560976 0.2560976\n",
       " [8] 0.2500000 0.2500000 0.2500000 0.2621951 0.2560976 0.2743902 0.2743902\n",
       "[15] 0.2621951 0.2621951 0.2682927 0.2682927 0.2560976"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li><li>11</li><li>12</li><li>13</li><li>14</li><li>15</li><li>16</li><li>17</li><li>18</li><li>19</li><li>20</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2\n",
       "\\item 3\n",
       "\\item 4\n",
       "\\item 5\n",
       "\\item 6\n",
       "\\item 7\n",
       "\\item 8\n",
       "\\item 9\n",
       "\\item 10\n",
       "\\item 11\n",
       "\\item 12\n",
       "\\item 13\n",
       "\\item 14\n",
       "\\item 15\n",
       "\\item 16\n",
       "\\item 17\n",
       "\\item 18\n",
       "\\item 19\n",
       "\\item 20\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2\n",
       "2. 3\n",
       "3. 4\n",
       "4. 5\n",
       "5. 6\n",
       "6. 7\n",
       "7. 8\n",
       "8. 9\n",
       "9. 10\n",
       "10. 11\n",
       "11. 12\n",
       "12. 13\n",
       "13. 14\n",
       "14. 15\n",
       "15. 16\n",
       "16. 17\n",
       "17. 18\n",
       "18. 19\n",
       "19. 20\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 19 × 3 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>I</th><th scope=col>A</th><th scope=col>E</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td> 2</td><td>0.6463415</td><td>0.3536585</td></tr>\n",
       "\t<tr><td> 3</td><td>0.7134146</td><td>0.2865854</td></tr>\n",
       "\t<tr><td> 4</td><td>0.7256098</td><td>0.2743902</td></tr>\n",
       "\t<tr><td> 5</td><td>0.7439024</td><td>0.2560976</td></tr>\n",
       "\t<tr><td> 6</td><td>0.7317073</td><td>0.2682927</td></tr>\n",
       "\t<tr><td> 7</td><td>0.7439024</td><td>0.2560976</td></tr>\n",
       "\t<tr><td> 8</td><td>0.7439024</td><td>0.2560976</td></tr>\n",
       "\t<tr><td> 9</td><td>0.7500000</td><td>0.2500000</td></tr>\n",
       "\t<tr><td>10</td><td>0.7500000</td><td>0.2500000</td></tr>\n",
       "\t<tr><td>11</td><td>0.7500000</td><td>0.2500000</td></tr>\n",
       "\t<tr><td>12</td><td>0.7378049</td><td>0.2621951</td></tr>\n",
       "\t<tr><td>13</td><td>0.7439024</td><td>0.2560976</td></tr>\n",
       "\t<tr><td>14</td><td>0.7256098</td><td>0.2743902</td></tr>\n",
       "\t<tr><td>15</td><td>0.7256098</td><td>0.2743902</td></tr>\n",
       "\t<tr><td>16</td><td>0.7378049</td><td>0.2621951</td></tr>\n",
       "\t<tr><td>17</td><td>0.7378049</td><td>0.2621951</td></tr>\n",
       "\t<tr><td>18</td><td>0.7317073</td><td>0.2682927</td></tr>\n",
       "\t<tr><td>19</td><td>0.7317073</td><td>0.2682927</td></tr>\n",
       "\t<tr><td>20</td><td>0.7439024</td><td>0.2560976</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 19 × 3 of type dbl\n",
       "\\begin{tabular}{lll}\n",
       " I & A & E\\\\\n",
       "\\hline\n",
       "\t  2 & 0.6463415 & 0.3536585\\\\\n",
       "\t  3 & 0.7134146 & 0.2865854\\\\\n",
       "\t  4 & 0.7256098 & 0.2743902\\\\\n",
       "\t  5 & 0.7439024 & 0.2560976\\\\\n",
       "\t  6 & 0.7317073 & 0.2682927\\\\\n",
       "\t  7 & 0.7439024 & 0.2560976\\\\\n",
       "\t  8 & 0.7439024 & 0.2560976\\\\\n",
       "\t  9 & 0.7500000 & 0.2500000\\\\\n",
       "\t 10 & 0.7500000 & 0.2500000\\\\\n",
       "\t 11 & 0.7500000 & 0.2500000\\\\\n",
       "\t 12 & 0.7378049 & 0.2621951\\\\\n",
       "\t 13 & 0.7439024 & 0.2560976\\\\\n",
       "\t 14 & 0.7256098 & 0.2743902\\\\\n",
       "\t 15 & 0.7256098 & 0.2743902\\\\\n",
       "\t 16 & 0.7378049 & 0.2621951\\\\\n",
       "\t 17 & 0.7378049 & 0.2621951\\\\\n",
       "\t 18 & 0.7317073 & 0.2682927\\\\\n",
       "\t 19 & 0.7317073 & 0.2682927\\\\\n",
       "\t 20 & 0.7439024 & 0.2560976\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 19 × 3 of type dbl\n",
       "\n",
       "| I | A | E |\n",
       "|---|---|---|\n",
       "|  2 | 0.6463415 | 0.3536585 |\n",
       "|  3 | 0.7134146 | 0.2865854 |\n",
       "|  4 | 0.7256098 | 0.2743902 |\n",
       "|  5 | 0.7439024 | 0.2560976 |\n",
       "|  6 | 0.7317073 | 0.2682927 |\n",
       "|  7 | 0.7439024 | 0.2560976 |\n",
       "|  8 | 0.7439024 | 0.2560976 |\n",
       "|  9 | 0.7500000 | 0.2500000 |\n",
       "| 10 | 0.7500000 | 0.2500000 |\n",
       "| 11 | 0.7500000 | 0.2500000 |\n",
       "| 12 | 0.7378049 | 0.2621951 |\n",
       "| 13 | 0.7439024 | 0.2560976 |\n",
       "| 14 | 0.7256098 | 0.2743902 |\n",
       "| 15 | 0.7256098 | 0.2743902 |\n",
       "| 16 | 0.7378049 | 0.2621951 |\n",
       "| 17 | 0.7378049 | 0.2621951 |\n",
       "| 18 | 0.7317073 | 0.2682927 |\n",
       "| 19 | 0.7317073 | 0.2682927 |\n",
       "| 20 | 0.7439024 | 0.2560976 |\n",
       "\n"
      ],
      "text/plain": [
       "      I  A         E        \n",
       " [1,]  2 0.6463415 0.3536585\n",
       " [2,]  3 0.7134146 0.2865854\n",
       " [3,]  4 0.7256098 0.2743902\n",
       " [4,]  5 0.7439024 0.2560976\n",
       " [5,]  6 0.7317073 0.2682927\n",
       " [6,]  7 0.7439024 0.2560976\n",
       " [7,]  8 0.7439024 0.2560976\n",
       " [8,]  9 0.7500000 0.2500000\n",
       " [9,] 10 0.7500000 0.2500000\n",
       "[10,] 11 0.7500000 0.2500000\n",
       "[11,] 12 0.7378049 0.2621951\n",
       "[12,] 13 0.7439024 0.2560976\n",
       "[13,] 14 0.7256098 0.2743902\n",
       "[14,] 15 0.7256098 0.2743902\n",
       "[15,] 16 0.7378049 0.2621951\n",
       "[16,] 17 0.7378049 0.2621951\n",
       "[17,] 18 0.7317073 0.2682927\n",
       "[18,] 19 0.7317073 0.2682927\n",
       "[19,] 20 0.7439024 0.2560976"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "A\n",
    "E\n",
    "I\n",
    "cbind(I,A,E)    #accuracy rate and error rate for different values of I\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "10a0ca8d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.492599Z",
     "iopub.status.busy": "2022-05-07T07:40:25.490979Z",
     "iopub.status.idle": "2022-05-07T07:40:25.775606Z",
     "shell.execute_reply": "2022-05-07T07:40:25.772490Z"
    },
    "papermill": {
     "duration": 0.296199,
     "end_time": "2022-05-07T07:40:25.778892",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.482693",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>8</li><li>9</li><li>10</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 8\n",
       "\\item 9\n",
       "\\item 10\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 8\n",
       "2. 9\n",
       "3. 10\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1]  8  9 10"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\ncBP02AGAjGBnTOqh2IKCgpycHG2HAWoPPXYAICPYGZN88YnTp09rOAkAAHAagp0xNWrUyGQy\nKdvvv/++prMAAAAnIdgZU7169QYMGKBsL1myhEU7GBU9dgAgI9gZ1qxZs5T2h/z8/JkzZ2o9\nDlAr6LEDABnBzrBuvvnm+++/X9l+9913jx07pu08QG1QeuwSExMTEhLosQMA9oNGNmvWLC8v\nLyFESUlJbGys1uMANY8eOwCQEeyMrHHjxo888oiyvX79+p9//lnbeYAaR48dAMgIdgYXGxvr\n5+cnhCgrK5s6darW4wA1jB47AJAR7AwuKipq7Nixyvann366a9cubecBAAC1h2BnfC+99FJw\ncLCyPWnSJG2HAQAAtYdgZ3zBwcHPPfecsr1z584vv/xS23mAGkSPHQDICHZu4dlnn42IiFC2\nJ06cyMmDMAx67ABARrBzC3Xq1Hn55ZeV7X379m3atEnbeYCaQo8dAMjYD7qLJ598skmTJsr2\n5MmTS0tLtZ0HqBH02AGAjGDnLry8vKZMmaJs//bbb6tXr9Z2HqBG0GMHADKCnRsZMWLEjTfe\nqGxPnTq1oKBA23mA6qPHDgBkBDs34uHh8eqrryrbp06dWrFihbbzAACAmkWwcy933313dHS0\nsj1r1qycnBxt5wEAADXICMHOWnBq0+p3Xpsz7521n/6exzkB9phMphkzZijb6enpCxcu1HYe\noJrosQMAmc6CXeaBT0bc2f36UL/gqBZj3/haCJH+w3utw5sMHfn4pJcnPj5iUPPwZrEfHdZ6\nTJfWp0+fXr16Kduvv/762bNntZ0HqA567ABApqdgl5/235vb37M2/ptzphDr+WPLXuj9j3Vf\n9e351PGSek+9NHPl+ytinx8ZUHJy5gN/ezflgtbDurS5c+eaTCYhRG5u7rx587QeB6g6euwA\nQKan/eCW4U+eLi6btP7H/PQ/s3LPxN5x3arhffcX1f3kSPKy2a/8Y+Tj0+a/f2zf+162gikP\nbtZ6WJfWoUOHQYMGKdtLly49efKktvMAVUaPHQDI9BTs5uw+G9BoypwHbhVCmL3CJ65ZKIQI\n77jszuv81ccEtR4xr3nw+f1vaDalTsyaNcvDw0MIUVhYqH7rDtAdeuwAQKanYHessNQvooP6\nn951uwohAm9sUO5hra6rYy084dTJdOimm2568MEHle333nsvOTlZ23mAqqHHDgBkegp2MXW9\n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\ns3ZUVFRISEhJ44OiQx07TeLurNvZ2dWtW5ffYHhhZ2fn4uLC2hs2bBBCJct37945OjpevnyZ\nbdavXz8yMlJk4025ospJSUlr167lNxjhQ2IHfCpdunTPnj1Z29/fX93L9fj7+9+/f5+1lyxZ\nYmJiUsIDTps2rXLlyqyNSksgbvHx8RcvXmRtHeyH5fj4+HCVLL+6DqG6vX792snJKTo6mm02\na9bs4sWL33zzDb9RqVzHjh25KSBr167lyijCZ2ljYqdI+Ed5OpI8OuLEL2v8VqxeF3D6UopM\n+xby03HcX4jnz59znaTqkJOTs3TpUtauU6fOmDFjSn5MMzOzBQsWsPbdu3e5YcsA4nPgwAGZ\nTEZEUql00KBBfIfDm8aNG3Pd0Dt37uRxAEBcXFyHDh24L6utWrUKDQ2tUKECX/GoFbecY1pa\n2ooVK/gOR9C0LLGLO7upY/0K9Z3/Xc0m813EgGbW3zr2nuruMX/2jKEu9lZVW26NeM1vkFAk\n3333HTdSTa1TKLZu3fr06VPW9vb2ZhNyS27ixIk1a9Zk7YULF6I3UMNQx05juF9PJycnbkkA\n3eTt7c0qWebm5nL1ODTs4cOH9vb2T548YZuOjo7nz5/nrqXi06JFi/79+7P25s2bnz17xm88\nQqZNid372z836DH5Umx2K8eqRKSQpbo2cwm687ZJjzHeq3/9fduGWT+4yN/e/qlL08D4dL6D\nhcIyNDTkfl0DAgLUtA5jenq6j48Pazdp0mTgwIGqOnK+Sku///67qo4MhYE6dpoRGxt78+ZN\n1tblfljGxsZm7NixrB0QEHDnzh0NB3Dr1i0HB4dXr16xTRcXl9OnT5cuXVrDYWiYj48P+0Ke\nk5OzbNkyvsMRMIX2WFzHQqpntuv6O7b5KnwwETWfc1L5OW+v/GoklVjZ71HheVmf3bJly1R4\nTFDGVZUjoj/++EMdp1Be1DUkJES1B5fJZFylJWtr6/T0dNUeHwqWm5sbHh6em5vLdyBixn17\nMTIySkpK4jsc/sXHx3MTv3r27KnJU0dGRpYtW5a7oLm6uubk5GgyAB59//337F3r6endv3+f\nx0iioqKIaN26dTzG8CXadMduY1yKRd3137f8dwBB3P67RLRzUVfl51Rs/dPP9cq9v+XLQ3xQ\nXI6OjlzPjjp6Y5OTk3/++WfWtre37969u2qPL5VKueWG4uPjN2/erNrjQwFQx04zuF9MFxcX\nc3NzfoMRAisrq8mTJ7P2yZMnNVbJMiwsrEePHh8/fmSbI0eO9Pf3151BCF5eXkZGRkQkk8mK\ntMa3TlHNMCPNKKcvTTb6/1vNUkMpEVUzyv8WalYwlv2NYXbaRCqVurq6rlmzhoiOHj26efPm\nks9XVebr68uVPuKmzatWnz59WrduffXqVXaKH374oSQV8qDw8tWxE00NjpcvXx4/frxLly51\n6tThOxa6cePG48ePWVs3y9d91ty5c7dt25acnExEM2fOHDx4sLrPmJaWtmrVKq6U4PTp09es\nWcOmFOiIatWqubm5sZVwg4KCbty40bJlS76DEh6+bxkWwaaWFfWNql1Jzmab725MJKJpV94o\nP0eem9i+jJFZpZEqPC+6YjXg+vXr3GcyMDBQhUfWWI+Jcofy4sWL1XciUKZc1/revXt8h6Ma\naWlpNWrUICIzM7OzZ8/yHY6CW6ClTJkyGRkZfIcjIMpjPDRs4cKFfL97frx9+5YbTdi1a1e+\nwkBXrGoM27fcIO8fpwZOG49EfsyTV2ixcXb7ylu69fwt/N+pjhmvr8/o3exSSrbDonn8hgpF\n1bJlS+5ei2p7Y729vdnyglKpVK1XYScnJ67S0po1axISEtR3LhC39evXx8XFEVF6enqvXr2C\ng4N5DEYul3PFw/v166fau+nabvr06ZUqVdLwSSUSycqVK7niTbqmYsWKM2bMYO2zZ8+GhYXx\nG48AaVNXbNm6428fincaunTywI7TjMxr169buax19scbYzvVmlqh2jdm2X8/fydTKNr/sC7Y\nrQHfwUKRDR06lK0JePr06eTkZJWM43n69On27dtZe8iQIdwUBzVZvnx5aGioQqFITU1dsWIF\n61wGKJKkpKRVq1Zxm9nZ2QMHDty9e/ewYcN4iSc8PDw+Pp61MR82HzMzsz179syePTstLU0z\nZzQ2Np41axY3h0A3ubu7b9y4ka3VO3/+fG7VDfgX37cMiywr8f4az586NK1b2lBP+Y2UrVS9\nq+ukveGxKj8jumI1IyYmhvvf3LFjh0qOOWLECHZAAwODx48EDOAJAAAgAElEQVQfq+SYBeNK\ntxgbGz9//lwDZ9Rxyh+bmJgYvsNRAQ8PD+4dccOnpFLptm3beIln/PjxLIZKlSph6jEIhPJC\nvceOHdN8AOiKVSUji4Yzlv168U5MSlbmh3fxL54/f/X6bXJqTvKbuDMBm0c41OI7QCimunXr\ncsNgVdIbe+/evf3797P22LFjNTMInau0lJWVpbN9JZoksjp2r1+/3rBhA2u7uLhs3ryZrV4l\nl8snTpzITe7WmJycnKCgINZ2dXVVVVlvgBKaMmUKt3Kap6cnZsQr077ELufji4shh39dv/nI\n6csmlpWrVqtmXbli2VL/P9n7fvChffv28RghFBvX0RMWFsbV3iy2+fPns992Y2NjT0/PkgZX\nOPXq1Rs+fDhr//777w8fPtTMeXWWVCoNDQ0NDw8PDQ1lOZBWW7ZsGRsSKpFIli1bNnHixL17\n97J0SqFQzJo1S/l+ngacOnUqMTGRtdEPC8KhfFVX/g4PRNrWFXt565RKSj2wpaq33nvnQ77n\nLK9RVrXvC12xGhMfH6+n9+//75o1a0pyqKtXr3LdWLNnz1ZVhIURFxfHKi0R0aBBgzR5ah0k\nk8m4O3YymYzvcErk2bNnbKEqIho6dCi3//jx48bGxtx1b/LkyXK5XDMhcWvC1qxZU2MnBSiM\n3NzcevXqsc9njRo1srOzNXl2dMWqxrtrXu0n/ZogLzNy+oKNW36ZO74nvbw+xq5h4D8aGrUK\n6mZlZdWxY0fWLmFvrIeHh0KhIKKyZcvOnTtXBcEVWvXq1SdMmMDahw8fvnbtmibPrmvy1bHj\nO5wS8fT0zMnJISJ9fX3lFUh79ep16tSpUqVKsc1ff/110qRJGuh7Sk1NPXnyJGsPHTpUp+ql\ngfAp/5rExcXt2LGD33iEQ5sSu52jNpDUbHf0kz1rvX+cONl3+4mY82uMZQk/dJyYKVfwHR2o\nBtfdc/36da4malGdOXOGmwM/a9YsS0tL1QRXaAsXLmSVlhQKBcqjq1Vubu5n21rn3r173JeZ\ncePGcbciGCcnp9OnT3NVr7dt2zZ8+HB1v9+goKDMzEzWRl1iEKAhQ4Y0a9aMtb29vdPTsUw8\nkXYldpvjUi1t149oaMHtsXaYdn5J25S4/QN2xBTwQtAiAwcO5Poxi3fTTjmXqlChwrRp01QW\nXKFVqFBh6tSprK2cZQJ8yVeHhHbo0OHChQvly5dnmwEBAf3798/KylJfSNwvYNOmTW1tbdV3\nIoDiYUNRWfv169e//PILv/EIhDYldmkyuXGFqvl22nmc6l7eJHR67wcZebxEBaplYWHBreVa\nvMROuffT09OTq1GuYbNnz+buFHL9wgCfde3aNa7TU3m6Xz4tWrS4ePGitbU12zx58mSPHj1S\nU1PVEVJCQgK3mAqmTYBgubi4sFG2ROTn58fN9dFl2pTYOZkbJ9xcmSb7nz+QEr2yu0/Ol2XF\ndh/4C/5yigP3VyQmJubWrVtFeq1MJuNGXVSvXn3ixIkqDq7QypYtO2fOHNZW/rMNqqW8/Ln2\nLoVe+CGhDRo0iIqKqlmzJtsMDw93dnZWxx+zgwcP5uXlEZFEInF1dVX58QFUhVtSKDk5efXq\n1fwGIwTalNh5jK+flRTaYqjXvfj/6Uev2Nrz8PgG/4TMtJ+29aOsaNmdTCY7ceLEoQKxtX1Q\nJkdj+vTpw40lKupNO+UKI15eXlyvLi+mTp3K3XrhOtpAtURQx66oQ0JtbGzCwsK4JfiuXbvW\npUsXlS9hx/3q2dvbs4VrAYTJ3t6+R48erL1u3bqSl8rSerzOyS0aWc7boU3KEZFEomdVo07Q\n+/9fi1qW+2F+z1pEZFy+po2xfuHf17lz5wr5g/rhhx/U87bgM0aOHMl+7NbW1nl5eYV8VWZm\nZrVq1dgL69WrJ4Qq+Zs3b+Y+Qv7+/nyHI065ubnh4eFC+O8uBrlcbmdnxz4hFSpUSElJKeQL\n37x5o7xEXoMGDV6+fKmqqOLi4rg5sJs2bVLVYQHUJDo6mitj+dNPP2ngjEIud6JNiZ1CoZDl\nJuxYOqVD8waWZUv99ib9fx6TZ+9ZNrF+JdMiJax5eXnHjx8PLNDo0aOJKCwsTOVvB77k9OnT\n3F+swv/klddmPXLkiDoDLKycnBzuNpLmKy3pAm2vYxcYGMh9aNevX1+k1yYmJrZp04Z7eY0a\nNWJjVbOm4vLly9kx9fX13759q5JjAqgVN2DAwMBAVb8IBUBip0l5Lx9Hh509rcIjrlu3joii\noqJUeEwoWG5ubqVKldhv6YQJEwrzktTU1IoVK7KXtGzZUjjFVJXXQcHND5XT6rVi8/LyGjRo\nwIKvXr16VlZWUY+QmprauXNn7idgZWV17969kgfGzYF1cXEp+dEANODx48fcKNtRo0ap+3RC\nTuy0aYxd4ehVqdPEsUsPvsOAEtHX1x84cCBrHzp0KDs7+6svWbNmzbt371h7xYoVwimmOmTI\nkG+//Za1uQWjQFW0uo7d7t27SzgktFSpUsePH+cmkr9+/drJyenOnTslieru3bv37t1jbcyH\nBW1Rp04dtkwUEfn7+0dHR/MaDp/El9iBSHB/UZKSks6cOVPwkz98+MCtj96xY0dnZ2f1BlcU\n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"
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
    "which(min(E)==E)\n",
    "plot(2:20,E,\"l\",lwd=2,main=\"Error rate for different values of I\")\n",
    "abline(h=min(E),lty=2,lwd=2)\n",
    "abline(v=10,lty=2,lwd=2)\n",
    "points(10,min(E),pch=21,cex=3,col=\"red\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "311bd262",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.798025Z",
     "iopub.status.busy": "2022-05-07T07:40:25.796357Z",
     "iopub.status.idle": "2022-05-07T07:40:25.815559Z",
     "shell.execute_reply": "2022-05-07T07:40:25.813451Z"
    },
    "papermill": {
     "duration": 0.031496,
     "end_time": "2022-05-07T07:40:25.818331",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.786835",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.25"
      ],
      "text/latex": [
       "0.25"
      ],
      "text/markdown": [
       "0.25"
      ],
      "text/plain": [
       "[1] 0.25"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min(E)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "e00af70d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.836992Z",
     "iopub.status.busy": "2022-05-07T07:40:25.835299Z",
     "iopub.status.idle": "2022-05-07T07:40:25.855091Z",
     "shell.execute_reply": "2022-05-07T07:40:25.853236Z"
    },
    "papermill": {
     "duration": 0.032218,
     "end_time": "2022-05-07T07:40:25.858095",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.825877",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "K1<-knn(train=TR[,-6],test=TS[,-6],cl=TR[,6],k=10)\n",
    "\n",
    "TTM<-table(TS[,6],K1)\n",
    "\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "41cb1cca",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.876970Z",
     "iopub.status.busy": "2022-05-07T07:40:25.875304Z",
     "iopub.status.idle": "2022-05-07T07:40:25.896903Z",
     "shell.execute_reply": "2022-05-07T07:40:25.894685Z"
    },
    "papermill": {
     "duration": 0.033953,
     "end_time": "2022-05-07T07:40:25.899700",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.865747",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.73780487804878"
      ],
      "text/latex": [
       "0.73780487804878"
      ],
      "text/markdown": [
       "0.73780487804878"
      ],
      "text/plain": [
       "[1] 0.7378049"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "A1<-sum(diag(TTM))/sum(TTM)\n",
    "A1\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "144b7a0f",
   "metadata": {
    "papermill": {
     "duration": 0.007842,
     "end_time": "2022-05-07T07:40:25.915251",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.907409",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Accuracy rate is 0.7134146 that is 71.34%."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "b4c46786",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-05-07T07:40:25.934375Z",
     "iopub.status.busy": "2022-05-07T07:40:25.932687Z",
     "iopub.status.idle": "2022-05-07T07:40:25.958341Z",
     "shell.execute_reply": "2022-05-07T07:40:25.956039Z"
    },
    "papermill": {
     "duration": 0.037953,
     "end_time": "2022-05-07T07:40:25.961088",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.923135",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.26219512195122"
      ],
      "text/latex": [
       "0.26219512195122"
      ],
      "text/markdown": [
       "0.26219512195122"
      ],
      "text/plain": [
       "[1] 0.2621951"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "E1<-1-A1\n",
    "E1"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3104866d",
   "metadata": {
    "papermill": {
     "duration": 0.008433,
     "end_time": "2022-05-07T07:40:25.977597",
     "exception": false,
     "start_time": "2022-05-07T07:40:25.969164",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Th error rate 0.286583 that is 28.65%\n"
   ]
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
   "duration": 5.843293,
   "end_time": "2022-05-07T07:40:26.108976",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-05-07T07:40:20.265683",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
